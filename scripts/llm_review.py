#!/usr/bin/env python3
"""
Splits the PR diff by file, calls Claude once per changed .cs/.csproj file, and
posts EACH file's review as its own PR comment immediately — rather than one
giant call for the whole diff. This means:
  - Smaller, faster calls (less likely to time out than one big request).
  - Visible progress: you see a comment land after each file, not one long
    silent wait.
  - Partial-failure isolation: if one file's review call fails, the others
    still post — one bad file doesn't take down the whole review (same
    per-recipient isolation pattern as your NotificationService).

Fails OPEN per-file: an error on file A gets a short debug comment for file A
only, and the loop continues to file B. Nothing here should ever exit non-zero
(see backend-review.yml, this step also has continue-on-error: true as a
second layer of safety).
"""
import os
import re
import sys
import json
import urllib.request
import urllib.error

MODEL = "claude-sonnet-5"
MAX_TOKENS = 38000          # smaller now — each call only covers one file
REQUEST_TIMEOUT = 150      # seconds; per-file calls should be much faster than the old whole-diff call
API_URL = "https://api.anthropic.com/v1/messages"
REVIEWABLE_EXTENSIONS = (".cs", ".csproj")


def read_file(path: str, max_chars: int = 60_000) -> str:
    if not os.path.exists(path):
        return ""
    with open(path, "r", errors="replace") as f:
        content = f.read()
    if len(content) > max_chars:
        content = content[:max_chars] + "\n\n[...truncated...]"
    return content


def split_diff_by_file(diff_text: str):
    """Splits a unified diff into (filename, chunk_text) pairs, one per file."""
    if not diff_text.strip():
        return []
    # Each file's section in `git diff` output starts with a line like:
    # "diff --git a/Mars.API/Foo.cs b/Mars.API/Foo.cs"
    # We split right before each such line, keeping it attached to its chunk.
    parts = re.split(r"(?=^diff --git )", diff_text, flags=re.MULTILINE)
    chunks = []
    for part in parts:
        if not part.strip():
            continue
        match = re.match(r"^diff --git a/(.*?) b/(.*?)\s*$", part, flags=re.MULTILINE)
        filename = match.group(2) if match else "unknown file"
        chunks.append((filename, part))
    return chunks


def call_claude(api_key: str, system_prompt: str, user_content: str):
    """Returns (review_text, error_summary, error_detail). Exactly one of the
    first or the last two will be populated."""
    payload = {
        "model": MODEL,
        "max_tokens": MAX_TOKENS,
        "system": system_prompt,
        "messages": [{"role": "user", "content": user_content}],
    }
    req = urllib.request.Request(
        API_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=REQUEST_TIMEOUT) as resp:
            body = json.loads(resp.read())
    except urllib.error.HTTPError as e:
        try:
            error_body = e.read().decode("utf-8", errors="replace")
        except Exception:
            error_body = "(could not read error response body)"
        return None, f"HTTP {e.code} from Claude API", error_body
    except (urllib.error.URLError, TimeoutError) as e:
        return None, "Network error calling Claude API", str(e)
    except Exception as e:
        return None, "Unexpected error calling Claude API", str(e)

    text_blocks = [b["text"] for b in body.get("content", []) if b.get("type") == "text"]
    review_text = "\n".join(text_blocks).strip()
    if not review_text:
        return None, "Claude responded but no review text was in the response", json.dumps(body, indent=2)[:3000]
    return review_text, None, None


def post_pr_comment(repo: str, pr_number: str, gh_token: str, body: str) -> tuple[bool, str]:
    """Posts a comment directly via the GitHub REST API. Returns (success, error_detail)."""
    url = f"https://api.github.com/repos/{repo}/issues/{pr_number}/comments"
    req = urllib.request.Request(
        url,
        data=json.dumps({"body": body}).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {gh_token}",
            "Accept": "application/vnd.github+json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            resp.read()
        return True, ""
    except Exception as e:
        return False, str(e)


def build_comment(filename: str, review_text: str = None, error_summary: str = None, error_detail: str = None) -> str:
    if review_text is not None:
        return f"### Review: `{filename}`\n\n{review_text}\n"
    return (
        f"### Review: `{filename}`\n\n"
        f"_Could not complete: **{error_summary}**_\n\n"
        "<details><summary>Error detail (temporary, for debugging)</summary>\n\n"
        f"```\n{error_detail}\n```\n"
        "</details>\n"
    )


def main() -> int:
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    gh_token = os.environ.get("GH_TOKEN")
    repo = os.environ.get("GITHUB_REPOSITORY")
    pr_number = os.environ.get("PR_NUMBER")

    if not all([api_key, gh_token, repo, pr_number]):
        missing = [name for name, val in [
            ("ANTHROPIC_API_KEY", api_key), ("GH_TOKEN", gh_token),
            ("GITHUB_REPOSITORY", repo), ("PR_NUMBER", pr_number),
        ] if not val]
        print(f"Missing required env vars: {missing} — aborting.", file=sys.stderr)
        return 0

    diff = read_file("diff.patch")
    file_chunks = split_diff_by_file(diff)
    file_chunks = [(name, chunk) for name, chunk in file_chunks if name.endswith(REVIEWABLE_EXTENSIONS)]

    if not file_chunks:
        post_pr_comment(repo, pr_number, gh_token,
                         "## Backend Review (LLM step)\n\n_No .cs/.csproj changes detected in this diff._")
        return 0

    review_criteria = read_file("REVIEW.md")
    if not review_criteria.strip():
        post_pr_comment(repo, pr_number, gh_token,
                         "## Backend Review (LLM step)\n\n_REVIEW.md not found at repo root — aborting._")
        return 0

    build_output = read_file("build-output.txt", max_chars=15_000)
    vulnerable_packages = read_file("vulnerable-packages.txt", max_chars=5_000)

    system_prompt = (
        "You are reviewing ONE file from a larger backend pull request. Follow the "
        "review criteria below exactly, including severity tags. Be concrete about "
        "mechanisms, never vague. If this file's changes look fine, say so briefly "
        "rather than inventing issues.\n\n" + review_criteria
    )

    print(f"Reviewing {len(file_chunks)} file(s): {[f for f, _ in file_chunks]}")

    for filename, chunk in file_chunks:
        # Only include build/vulnerability context lines that actually mention
        # this file, so each per-file call stays small and focused.
        relevant_build = "\n".join(
            line for line in build_output.splitlines() if filename in line
        ) or "(no warnings mentioning this file)"
        relevant_vuln = vulnerable_packages if vulnerable_packages.strip() else "(none found)"

        user_content = (
            f"## Diff for {filename}\n```diff\n{chunk}\n```\n\n"
            f"## Build/analyzer warnings mentioning this file\n```\n{relevant_build}\n```\n\n"
            f"## Vulnerable package scan (repo-wide)\n```\n{relevant_vuln}\n```\n"
        )

        review_text, err_summary, err_detail = call_claude(api_key, system_prompt, user_content)
        comment = build_comment(filename, review_text, err_summary, err_detail)

        ok, post_err = post_pr_comment(repo, pr_number, gh_token, comment)
        if not ok:
            print(f"Failed to post comment for {filename}: {post_err}", file=sys.stderr)
            # Don't abort the loop — try the remaining files anyway.

    return 0


if __name__ == "__main__":
    sys.exit(main())