using Domain.Abstractions;

namespace Domain.Entities.Orders;

public sealed class OrderItem : BaseEntity
{
    public decimal Price { get; set; }
    public int Count { get; set; }

    #region Relations

    public Order Order { get; set; }
    public Guid OrderId { get; set; }

    #endregion
}