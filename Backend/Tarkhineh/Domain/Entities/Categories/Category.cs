using Domain.Abstractions;
using Domain.Entities.Feedback;
using Domain.Entities.Foods;

namespace Domain.Entities.Categories;

public sealed class Category : BaseEntity
{
    public string Name { get; set; }

    #region Relations

    public IReadOnlyCollection<FoodCategory> FoodCategories { get; set; }

    public FoodType FoodType { get; set; }
    public Guid FoodTypeId { get; set; }


    #endregion
}