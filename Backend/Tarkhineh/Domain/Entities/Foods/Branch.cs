using Domain.Abstractions;
using Domain.Entities.Feedback;
using Domain.Entities.Orders;

namespace Domain.Entities.Foods;

public sealed class Branch : BaseEntity
{
    public string Name { get; set; }
    public string Address { get; set; }
    public string ImageUrl { get; set; }
    public string WorkHours { get; set; }
    public string PhoneNumber { get; set; }
    public double Latitude { get; set; }  // عرض جغرافیایی X
    public double Longitude { get; set; } // طول جغرافیایی Y


    #region Relations

    public IReadOnlyCollection<Order> Orders { get; set; }
    public IReadOnlyCollection<Comment> Comments { get; set; }

    #endregion
}