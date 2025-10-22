using Application.Features.Branches.Commands;
using Domain.Entities.Foods;

namespace Application.Features.Branches.Dtos;

public class BranchDto
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public string Address { get; set; }
    public string ImageUrl { get; set; }
    public string WorkHours { get; set; }
    public string PhoneNumber { get; set; }
    public double Latitude { get; set; }  // عرض جغرافیایی X
    public double Longitude { get; set; } // طول جغرافیایی Y
}

