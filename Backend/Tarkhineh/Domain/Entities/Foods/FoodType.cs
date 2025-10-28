using Domain.Abstractions;
using Domain.Entities.Categories;

namespace Domain.Entities.Foods;

public class FoodType : BaseEntity
{
    public string Name { get; set; }
    public string ImageUrl { get; set; }

    #region Relations

    public IReadOnlyCollection<Food> Foods { get; set; }
    public IReadOnlyCollection<Category> Categories { get; set; }


    #endregion
}