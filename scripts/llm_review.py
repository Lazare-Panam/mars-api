#!/usr/bin/env python3
"""
Reads the PR diff + static analysis artifacts + REVIEW.md, sends them to the
Claude API, and writes review-output.md for the workflow to post as a PR comment.

Designed to fail OPEN: any exception here writes a short fallback message and
exits 0, so a flaky API call never fails the pipeline (see backend-review.yml,
this step already has continue-on-error: true as a second layer of safety).
"""
import os
import sys
import json
import urllib.request
import urllib.error

MODEL = "claude-sonnet-5"
MAX_TOKENS = 16000
API_URL = "https://api.anthropic.com/v1/messages"

FALLBACK_MESSAGE = (
    "## Backend Review (LLM step)\n\n"
    "_The automated review could not run this time (see workflow logs for details). "
    "Static analysis and CodeQL results above are unaffected — this step is advisory only._\n"
)


def read_file(path: str, max_chars: int = 60_000) -> str:
    if not os.path.exists(path):
        return ""
    with open(path, "r", errors="replace") as f:
        content = f.read()
    if len(content) > max_chars:
        content = content[:max_chars] + "\n\n[...truncated, diff too large for full review...]"
    return content


def main() -> int:
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("ANTHROPIC_API_KEY not set — skipping LLM review.", file=sys.stderr)
        write_output(FALLBACK_MESSAGE)
        return 0

    diff = read_file("diff.patch")
    if not diff.strip():
        write_output("## Backend Review (LLM step)\n\n_No .cs/.csproj changes detected in this diff._\n")
        return 0

    build_output = read_file("build-output.txt", max_chars=15_000)
    vulnerable_packages = read_file("vulnerable-packages.txt", max_chars=5_000)
    review_criteria = read_file("REVIEW.md")

    if not review_criteria.strip():
        print("REVIEW.md not found at repo root — aborting LLM review.", file=sys.stderr)
        write_output(FALLBACK_MESSAGE)
        return 0

    system_prompt = (
        "You are reviewing a backend pull request. Follow the review criteria below exactly, "
        "including the output format and severity tags. Be concrete about mechanisms, never vague.\n\n"
        + review_criteria
    )

    user_content = (
        f"## Diff\n```diff\n{diff}\n```\n\n"
        f"## Build/analyzer output\n```\n{build_output or '(no warnings captured)'}\n```\n\n"
        f"## Vulnerable package scan\n```\n{vulnerable_packages or '(none found)'}\n```\n"
    )

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
        with urllib.request.urlopen(req, timeout=90) as resp:
            raw_body = resp.read()
            body = json.loads(raw_body)
    except urllib.error.HTTPError as e:
        # Anthropic puts the actual error message in the response BODY, not
        # just the HTTP status — e.read() gets that body, str(e) alone would
        # only give us "HTTP Error 401: Unauthorized" with no real explanation.
        try:
            error_body = e.read().decode("utf-8", errors="replace")
        except Exception:
            error_body = "(could not read error response body)"
        write_output(debug_output(f"HTTP {e.code} from Claude API", error_body))
        return 0
    except (urllib.error.URLError, TimeoutError) as e:
        write_output(debug_output("Network error calling Claude API", str(e)))
        return 0
    except Exception as e:
        write_output(debug_output("Unexpected error calling Claude API", str(e)))
        return 0

    text_blocks = [b["text"] for b in body.get("content", []) if b.get("type") == "text"]
    review_text = "\n".join(text_blocks).strip()

    if not review_text:
        write_output(debug_output(
            "Claude API responded but no review text was found in the response",
            json.dumps(body, indent=2)[:3000],
        ))
        return 0

    write_output(f"## Backend Review (automated)\n\n{review_text}\n")
    return 0


def debug_output(summary: str, detail: str) -> str:
    return (
        "## Backend Review (LLM step)\n\n"
        f"_The automated review could not complete: **{summary}**_\n\n"
        "<details><summary>Error detail (temporary, for debugging)</summary>\n\n"
        f"```\n{detail}\n```\n"
        "</details>\n\n"
        "_Static analysis and CodeQL results above are unaffected — this step is advisory only._\n"
    )


def write_output(content: str) -> None:
    with open("review-output.md", "w") as f:
        f.write(content)


if __name__ == "__main__":
    sys.exit(main())