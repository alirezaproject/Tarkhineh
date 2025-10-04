using Domain.Abstractions;
using Domain.Entities.Orders;

namespace Domain.Entities.Users;

public sealed class Address : BaseEntity
{
    public string Title { get; set; }
    public string PhoneNumber { get; set; }
    public bool IsUser { get; set; }
    public string ReceiverName { get; set; }
    public double Latitude { get; set; }  // عرض جغرافیایی X
    public double Longitude { get; set; } // طول جغرافیایی Y
    public string Location { get; set; }


    #region Relations

    public IReadOnlyCollection<Order> Orders { get; set; }

    public User User { get; set; }
    public Guid UserId { get; set; }
    

    #endregion
}