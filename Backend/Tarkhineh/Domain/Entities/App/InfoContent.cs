using Domain.Abstractions;
using Domain.Enums;

namespace Domain.Entities.App;

public sealed class InfoContent : BaseEntity
{
    public InfoType Type { get; set; }      // نوع محتوا

    public string Title { get; set; }       // عنوان
    public string Description { get; set; } // توضیحات متنی طولانی
}