using Azure.Messaging.ServiceBus;
using Mars.API.Models.User;
using Mars.API.Settings;
using Microsoft.Extensions.Options;
using Polly;
using Polly.Registry;
using System.Data.Common;
using System.Runtime.CompilerServices;
using System.Text.Json;

namespace Mars.API.MessageQueues
{
    public class EnquiryPublisher : IEnquiryPublisher
    {
        private readonly ServiceBusSender _sender;
        private readonly ILogger<EnquiryPublisher> _logger;
        private readonly ResiliencePipelineProvider<string> _resiliencePipeline;
        public EnquiryPublisher(ServiceBusClient client, IOptions<ServiceBusSettings> options, ILogger<EnquiryPublisher> logger, ResiliencePipelineProvider<string> pipelineProvider)
        {
            ServiceBusSettings settings = options.Value;
            string queueName = settings.EnquiryQueueName;
            _resiliencePipeline = pipelineProvider;
            _sender = client.CreateSender(queueName);
            _logger = logger;
        }
        public async Task PublishEnquiryRecievedAsync(Guid enquiryId, CancellationToken ct = default)
        {
            var pipeline = _resiliencePipeline.GetPipeline("azureServiceBus"); 
            var payload = new EnquiryReceivedMessage { EnquiryId = enquiryId };
            var message = new ServiceBusMessage(JsonSerializer.Serialize(payload))
            {
                ContentType = "application/json",
                Subject = nameof(EnquiryReceivedMessage),
                MessageId = enquiryId.ToString()
            };
            _logger.LogInformation("Publishing EnquiryReceived message {MessageId} for enquiry {EnquiryId}", message.MessageId, enquiryId);
            await pipeline.ExecuteAsync(async ct => await _sender.SendMessageAsync(message, ct),ct); 
        }
    }
}
