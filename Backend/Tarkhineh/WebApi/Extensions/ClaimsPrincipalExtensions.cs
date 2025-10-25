using System.Security.Claims;

namespace WebApi.Extensions;

public static class ClaimsPrincipalExtensions
{
    /// <summary>
    /// Returns the user's unique identifier (UserId) from JWT claims.
    /// Typically uses ClaimTypes.NameIdentifier or "sub".
    /// </summary>
    public static string? GetUserId(this ClaimsPrincipal user)
    {
        return user?.FindFirst(ClaimTypes.NameIdentifier)?.Value
               ?? user?.FindFirst("sub")?.Value;
    }

    /// <summary>
    /// Returns the user's username or email (depending on what you issued in the token).
    /// </summary>
    public static string? GetUserName(this ClaimsPrincipal user)
    {
        return user?.FindFirst(ClaimTypes.Name)?.Value
               ?? user?.FindFirst("username")?.Value;
    }

    /// <summary>
    /// Returns the user email from claims.
    /// </summary>
    public static string? GetEmail(this ClaimsPrincipal user)
    {
        return user?.FindFirst(ClaimTypes.Email)?.Value
               ?? user?.FindFirst("email")?.Value;
    }

    /// <summary>
    /// Returns all roles assigned to the user from claims.
    /// </summary>
    public static IEnumerable<string> GetRoles(this ClaimsPrincipal user)
    {
        return user?.FindAll(ClaimTypes.Role).Select(r => r.Value)
               ?? [];
    }

    /// <summary>
    /// Checks whether the user has a given role.
    /// </summary>
    public static bool IsInRole(this ClaimsPrincipal user, string role)
    {
        return user?.Claims.Any(c =>
            c.Type == ClaimTypes.Role && c.Value.Equals(role, StringComparison.OrdinalIgnoreCase)
        ) ?? false;
    }
}