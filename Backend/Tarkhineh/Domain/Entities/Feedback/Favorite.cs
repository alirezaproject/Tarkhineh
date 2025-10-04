using Domain.Abstractions;
using Domain.Entities.Foods;
using Domain.Entities.Users;

namespace Domain.Entities.Feedback;

public sealed class Favorite : BaseEntity
{
    public Guid UserId { get; set; }
    public User  User { get; set; }

    public Food Food { get; set; }
    public Guid FoodId { get; set; }
}