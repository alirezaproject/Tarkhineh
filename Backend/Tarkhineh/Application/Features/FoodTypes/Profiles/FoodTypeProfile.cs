using Application.Features.FoodTypes.Dtos;
using Domain.Entities.Foods;

namespace Application.Features.FoodTypes.Profiles;

public class FoodTypeProfile : Profile
{
    public FoodTypeProfile()
    {
        CreateMap<FoodType, FoodTypeDto>().ReverseMap();
    }
}