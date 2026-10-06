using Microsoft.Extensions.Logging;

namespace Mars.API.Logging
{
    /// <summary>
    /// EventIds for security-relevant events, so they can be filtered and alerted on
    /// (App Insights: <c>customDimensions.EventId</c>) without matching on message text.
    /// See docs/LOGGING_REVIEW_CHECKLIST.md §5.
    /// </summary>
    public static class LogEvents
    {
        // Registration: 1000-1099
        public static readonly EventId UserRegistered = new(1000, nameof(UserRegistered));
        public static readonly EventId RegistrationRejected = new(1001, nameof(RegistrationRejected));

        // Login / logout: 1100-1199
        public static readonly EventId LoginSucceeded = new(1100, nameof(LoginSucceeded));
        public static readonly EventId LoginFailed = new(1101, nameof(LoginFailed));
        public static readonly EventId AccountLockedOut = new(1102, nameof(AccountLockedOut));
        public static readonly EventId LoggedOut = new(1103, nameof(LoggedOut));

        // Tokens: 1200-1299
        public static readonly EventId TokenRejected = new(1200, nameof(TokenRejected));
        public static readonly EventId TokenExpired = new(1201, nameof(TokenExpired));

        // Input validation: 1300-1399
        public static readonly EventId ValidationFailed = new(1300, nameof(ValidationFailed));
    }
}
