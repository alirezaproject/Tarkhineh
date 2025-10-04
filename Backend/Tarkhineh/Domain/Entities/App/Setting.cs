using Domain.Abstractions;

namespace Domain.Entities.App;

public sealed class Setting : BaseEntity
{
    public string LogoUrl { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public string FooterImageUrl { get; set; }
    public string AboutUs { get; set; }
}