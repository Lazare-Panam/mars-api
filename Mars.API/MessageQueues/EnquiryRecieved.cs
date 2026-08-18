namespace Mars.API.MessageQueues
{
    using Azure.Messaging.ServiceBus;
    using global::Mars.API.Models.User;
    using global::Mars.API.Repository.SQL;
    using global::Mars.API.Services.Interfaces;
    using global::Mars.API.Settings;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.Options;
    using System.Text.Json;

    public class EnquiryReceivedConsumer : BackgroundService
    {
        private readonly ServiceBusClient _client;
        private readonly ServiceBusSettings _settings;
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly ILogger<EnquiryReceivedConsumer> _logger;
        private ServiceBusProcessor? _processor;

        public EnquiryReceivedConsumer(
            ServiceBusClient client,
            IOptions<ServiceBusSettings> options,
            IServiceScopeFactory scopeFactory,
            ILogger<EnquiryReceivedConsumer> logger)
        {
            _client = client;
            _settings = options.Value;
            _scopeFactory = scopeFactory;
            _logger = logger;
        }

        public override async Task StartAsync(CancellationToken cancellationToken)
        {
            _processor = _client.CreateProcessor(_settings.EnquiryQueueName, new ServiceBusProcessorOptions
            {
                MaxConcurrentCalls = 1,
                AutoCompleteMessages = false,
                MaxAutoLockRenewalDuration = TimeSpan.FromMinutes(5)
            });

            _processor.ProcessMessageAsync += HandleMessageAsync;
            _processor.ProcessErrorAsync += HandleErrorAsync;

            await _processor.StartProcessingAsync(cancellationToken);
            await base.StartAsync(cancellationToken);
        }

        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            return Task.CompletedTask;
        }

        public override async Task StopAsync(CancellationToken cancellationToken)
        {
            if (_processor is not null)
            {
                await _processor.StopProcessingAsync(cancellationToken);
                await _processor.DisposeAsync();
            }

            await base.StopAsync(cancellationToken);
        }

        private async Task HandleMessageAsync(ProcessMessageEventArgs args)
        {
            EnquiryReceivedMessage? payload;
            try
            {
                payload = JsonSerializer.Deserialize<EnquiryReceivedMessage>(args.Message.Body.ToString());
            }
            catch (JsonException ex)
            {
                _logger.LogError(ex, "Malformed EnquiryReceived message {MessageId} — dead-lettering, retry will not help.", args.Message.MessageId);
                await args.DeadLetterMessageAsync(args.Message, "MalformedPayload", ex.Message);
                return;
            }

            if (payload is null || payload.EnquiryId == Guid.Empty)
            {
                _logger.LogError("EnquiryReceived message {MessageId} had no valid EnquiryId — dead-lettering.", args.Message.MessageId);
                await args.DeadLetterMessageAsync(args.Message, "MissingEnquiryId");
                return;
            }

            await using var scope = _scopeFactory.CreateAsyncScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDBContext>();
            var notificationService = scope.ServiceProvider.GetRequiredService<INotificationService>();

            var enquiry = await dbContext.Enquiry
                .FirstOrDefaultAsync(e => e.Id == payload.EnquiryId, args.CancellationToken);

            if (enquiry is null)
            {
                _logger.LogError("Enquiry {EnquiryId} referenced by message {MessageId} was not found in the database — dead-lettering, retry will not help.", payload.EnquiryId, args.Message.MessageId);
                await args.DeadLetterMessageAsync(args.Message, "EnquiryNotFound");
                return;
            }

            var result = await notificationService.HandleNewEnquiryAsync(
                enquiry.UserName, enquiry.UserEmail, enquiry.UserCompany, enquiry.UserCountry, enquiry.Message);

            if (!result.ReceiptSent)
            {
                _logger.LogWarning("Receipt email not sent for enquiry {EnquiryId}.", enquiry.Id);
            }
            if (!result.InternalNotificationSent)
            {
                _logger.LogWarning("Internal notification not sent for enquiry {EnquiryId}.", enquiry.Id);
            }

            await args.CompleteMessageAsync(args.Message);
        }

        private Task HandleErrorAsync(ProcessErrorEventArgs args)
        {
            _logger.LogError(args.Exception, "Service Bus processor error. Source: {ErrorSource}", args.ErrorSource);
            return Task.CompletedTask;
        }
    }
}
