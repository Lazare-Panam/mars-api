namespace Mars.API.Services.Interfaces
{
    /// <summary>
    /// Keeps track of login tokens that were logged out before they expired, so they can't be used again.
    /// </summary>
    public interface ITokenRevocationService
    {
        /// <summary>
        /// Revokes a token until it would have expired anyway.
        /// </summary>
        /// <param name="tokenId">The token's unique id (its <c>jti</c> claim).</param>
        /// <param name="expiresAt">When the token expires; after that it's rejected anyway, so it's forgotten.</param>
        Task RevokeAsync(string tokenId, DateTimeOffset expiresAt, CancellationToken ct = default);

        /// <summary>
        /// Checks whether a token has been revoked (logged out).
        /// </summary>
        /// <param name="tokenId">The token's unique id (its <c>jti</c> claim).</param>
        /// <returns><c>true</c> if the token was logged out.</returns>
        Task<bool> IsRevokedAsync(string tokenId, CancellationToken ct = default);
    }
}
