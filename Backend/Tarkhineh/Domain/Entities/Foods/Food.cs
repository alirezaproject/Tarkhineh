using Domain.Abstractions;
using Domain.Entities.Categories;
using Domain.Entities.Feedback;
using System.Collections.Generic;

namespace Domain.Entities.Foods;

public sealed class Food : BaseEntity
{
    public string Name { get; set; }
    public string Ingredients { get; set; }
    public string ImageUrl { get; set; }
    public int Price { get; set; }
    public int? DiscountPercent { get; set; }
    public bool IsAvailable { get; set; }
    public bool IsSpecialOffer { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    #region Relations

    public IReadOnlyCollection<Rating> Ratings { get; set; }
    public IReadOnlyCollection<Favorite> Favorites { get; set; }
    public IReadOnlyCollection<FoodCategory> FoodCategories { get; set; }

    public FoodType FoodType { get; set; }
    public Guid FoodTypeId { get; set; }

    #endregion

}
