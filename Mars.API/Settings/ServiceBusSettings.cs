namespace Mars.API.Settings
{
    public class ServiceBusSettings
    {
        public string ConnectionString { get; set; } = string.Empty;
        public string EnquiryQueueName { get; set; } = string.Empty;
    }
}
