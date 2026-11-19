namespace Mars.API.Settings
{
    public class MeilisearchSettings
    {
        /// <summary>Meilisearch Cloud host URL, e.g. https://ms-xxxx.meilisearch.io. Set via user-secrets / env.</summary>
        public string Host { get; set; } = string.Empty;

        /// <summary>Admin/default API key. SERVER-SIDE ONLY — never shipped to the browser. Set via user-secrets / env.</summary>
        public string ApiKey { get; set; } = string.Empty;
    }
}
