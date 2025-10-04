using Domain.Abstractions;
using Domain.Enums;

namespace Domain.Entities.Orders;

public sealed class Discount : BaseEntity
{
    public string Code { get; set; }
    public string Title { get; set; }
    public DateTime StartDate { get; set; } 
    public DateTime EndDate { get; set; }
    public decimal Value { get; set; }
    public bool IsActive { get; set; }
    public DiscountType DiscountType { get; set; }
}