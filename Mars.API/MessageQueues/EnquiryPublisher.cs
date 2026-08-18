using Azure.Messaging.ServiceBus;
using Mars.API.Models.User;
using Mars.API.Settings;
using Microsoft.Extensions.Options;
using System.Runtime.CompilerServices;
using System.Text.Json;

namespace Mars.API.MessageQueues
{
    public class EnquiryPublisher : IEnquiryPublisher
    {
        private readonly ServiceBusSender _sender;
        private readonly ILogger<EnquiryPublisher> _logger;
        public EnquiryPublisher(ServiceBusClient client, IOptions<ServiceBusSettings> options, ILogger<EnquiryPublisher> logger)
        {
            ServiceBusSettings settings = options.Value;
            string queueName = settings.EnquiryQueueName;

            _sender = client.CreateSender(queueName);
            _logger = logger;
        }
        public async Task PublishEnquiryRecievedAsync(Guid enquiryId, CancellationToken ct = default)
        {
            
            var payload = new EnquiryReceivedMessage { EnquiryId = enquiryId };
            var message = new ServiceBusMessage(JsonSerializer.Serialize(payload))
            {
                ContentType = "application/json",
                Subject = nameof(EnquiryReceivedMessage),
                MessageId = enquiryId.ToString()
            };

            _logger.LogInformation("Publishing EnquiryReceived message {MessageId} for enquiry {EnquiryId}", message.MessageId, enquiryId);
            await _sender.SendMessageAsync(message, ct);
        }
    }
}
