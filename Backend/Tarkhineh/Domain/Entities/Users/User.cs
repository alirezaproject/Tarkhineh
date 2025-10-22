using Domain.Entities.Feedback;
using Microsoft.AspNetCore.Identity;

namespace Domain.Entities.Users;

public sealed class User :IdentityUser<Guid>
{
    public string? Name { get; set; }
    public string? Family { get; set; }
    public string? NickName { get; set; }
    public DateTime? BirthDate { get; set; }

    public string? RefreshToken { get; set; }
    public DateTime? RefreshTokenExpiryTime { get; set; }


    #region Relations

    public IReadOnlyCollection<Favorite> Favorites { get; set; }
    public IReadOnlyCollection<Address> Addresses { get; set; }
    
    #endregion
}