using Domain.Abstractions;
using Domain.Entities.Foods;

namespace Domain.Entities.Feedback;

public sealed class Rating : BaseEntity
{
    public byte Star { get; set; }
    
    #region Relations

    public Food Food { get; set; }
    public Guid FoodId { get; set; }


    #endregion
}