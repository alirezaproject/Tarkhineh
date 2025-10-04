using Domain.Abstractions;
using Domain.Enums;

namespace Domain.Entities.App;

public sealed class FeatureItem : BaseEntity
{
    public string Logo { get; set; }
    public string Title { get; set; }
    public FeatureItemType FeatureItemType { get; set; }

}