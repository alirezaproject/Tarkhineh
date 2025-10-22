namespace Application.Features.Foods.Dtos;

public class FoodDto
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public string Ingredients { get; set; }
    public string ImageUrl { get; set; }
    public int Price { get; set; }
    public int? DiscountPercent { get; set; }
    public bool IsSpecialOffer { get; set; }
    public bool IsFavorite { get; set; }
    public byte Star { get; set; }
    public int RateCount { get; set; }

}