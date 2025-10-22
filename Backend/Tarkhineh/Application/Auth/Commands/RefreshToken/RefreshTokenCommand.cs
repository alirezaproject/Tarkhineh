using Application.Common.Responses;
using Domain.Entities.Users;
using Microsoft.AspNetCore.Identity;

namespace Application.Auth.Commands.RefreshToken;

public record RefreshTokenCommand(string RefreshToken)
    : IRequest<JwtResponse>;



public class RefreshTokenCommandHandler(UserManager<User> userManager, IJwtService jwtService)
    : IRequestHandler<RefreshTokenCommand, JwtResponse>
{
    public async Task<JwtResponse> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var user = userManager.Users
            .FirstOrDefault(u => u.RefreshToken == request.RefreshToken);

        if (user == null || user.RefreshTokenExpiryTime <= DateTime.UtcNow)
            throw new UnauthorizedAccessException("Invalid or expired refresh token.");

        var newAccessToken = jwtService.GenerateToken(user);
        var newRefreshToken = jwtService.GenerateRefreshToken();

        user.RefreshToken = newRefreshToken;
        user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);
        await userManager.UpdateAsync(user);

        return new JwtResponse(newAccessToken, newRefreshToken);
    }
}
