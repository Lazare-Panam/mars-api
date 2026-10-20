namespace Mars.API.Settings
{
    public class EmailSettings
    {
        public string ConnectionString { get; set; }
        public string SenderAddress { get; set; }
        public string InternalAddressEmail { get; set; }
        public string AdminPortalUrl { get; set; }

        /// <summary>Public URL of the e-catalogue PDF, linked in the stock-list request email.</summary>
        public string CatalogueUrl { get; set; }

        /// <summary>Public URL of the stock-list PDF, linked in the stock-list request email.</summary>
        public string StockListUrl { get; set; }
    }
}
