namespace Mars.API.Models.User
{
    public class Enquiry
    {
        public Guid Id { get; set; }
        public string UserName { get; set; } = string.Empty;
        public string UserEmail { get; set; } = string.Empty;
        public string UserCompany { get; set; } = string.Empty;
        public string? UserCountry { get; set; }
        public string Message { get; set; } = string.Empty;
        public DateTime CreatedAtUtc { get; set; }
    }
}
