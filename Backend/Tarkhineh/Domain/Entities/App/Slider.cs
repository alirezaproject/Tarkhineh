using Domain.Abstractions;

namespace Domain.Entities.App;

public sealed class Slider : BaseEntity
{
    public string Title { get; set; }
    public string ImageUrl { get; set; }
    
}