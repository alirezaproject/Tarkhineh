using Domain.Abstractions;
using Domain.Entities.Feedback;

namespace Domain.Entities.Categories;

public sealed class Category : BaseEntity
{
    public string Name { get; set; }

    #region Relations

    public IReadOnlyCollection<FoodCategory> FoodCategories { get; set; }

    #endregion
}