using Domain.Abstractions;
using Domain.Entities.Foods;
using Domain.Entities.Users;
using Domain.Enums;

namespace Domain.Entities.Orders;

public sealed class Order : BaseEntity
{    
    
    public decimal TotalPrice { get; set; }
    public string Description { get; set; }
    public OrderDeliveryType OrderDeliveryType { get; set; }
    public PaymentMethodType PaymentMethodType { get; set; }
    public DateTime CreateAt { get; set; } = DateTime.UtcNow;
    public string TrackingCode { get; set; }
    public PaymentStatus PaymentStatus { get; set; }
    public OrderStatus OrderStatus { get; set; }

    #region Relations

    public User User { get; set; }
    public Guid UserId { get; set; }

    public Address Address { get; set; }

    public IReadOnlyCollection<OrderItem> OrderItems { get; set; }

    public Branch Branch { get; set; }

    #endregion

}