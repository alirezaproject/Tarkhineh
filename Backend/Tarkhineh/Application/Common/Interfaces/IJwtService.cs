using System.Security.Claims;
using Domain.Entities.Users;

namespace Application.Common.Interfaces;

public interface IJwtService : ITransientService
{
    string GenerateToken(User user);
    string GenerateRefreshToken();
    ClaimsPrincipal? GetPrincipalFromExpiredToken(string token);
}