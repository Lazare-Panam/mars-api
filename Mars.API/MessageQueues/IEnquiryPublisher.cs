namespace Mars.API.MessageQueues
{
    public interface IEnquiryPublisher
    {
        Task PublishEnquiryRecievedAsync(Guid enquiryId, CancellationToken ct = default);
    }
}
