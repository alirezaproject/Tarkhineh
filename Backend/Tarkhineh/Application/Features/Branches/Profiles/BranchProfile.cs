using Application.Features.Branches.Commands;
using Application.Features.Branches.Dtos;
using Domain.Entities.Foods;

namespace Application.Features.Branches.Profiles;

public class BranchProfile : Profile
{
    public BranchProfile()
    {
        CreateMap<BranchDto, Branch>().ReverseMap();
        CreateMap<CreateBranchCommand, Branch>();
    }
}