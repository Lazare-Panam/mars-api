namespace Mars.API.Models.Basket
{
    public class CreateRfqRequest
    {
        public List<CreateRfqLineItem> LineItems { get; set; } = new List<CreateRfqLineItem>();
    }
    public class CreateRfqLineItem
    {
        public string ProductId { get; set; } = string.Empty;
        public string ProductDescription { get; set; } = string.Empty;
        public int Quantity { get; set; }
        public string PictureUrl { get; set; } = string.Empty;
    }
}
