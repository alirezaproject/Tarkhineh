namespace Application.Common.Responses;

public record JwtResponse(string AccessToken, string RefreshToken);