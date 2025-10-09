namespace Application.Common.Interfaces;

public interface IJwtService : ITransientService
{
    string GenerateToken(Guid userId, string username, string[] roles);
}