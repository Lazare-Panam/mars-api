namespace Mars.API.Models.User
{
    public class EnquiryRequest
    {
        public string UserName { get; set; }
        public string UserEmail { get; set; }
        public string UserCompany { get; set; }
        public string UserCountry { get; set; }
        public string Message { get; set; }
    }
}
