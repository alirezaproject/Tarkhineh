using Domain.Abstractions;
using Domain.Entities.Foods;

namespace Domain.Entities.Categories;

public sealed class FoodCategory : BaseEntity
{
    public Guid CategoryId { get; set; }
    public Category Category { get; set; }

    public Food Food { get; set; }
    public Guid FoodId { get; set; }


}