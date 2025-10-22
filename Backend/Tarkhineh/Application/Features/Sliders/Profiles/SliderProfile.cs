using Application.Features.Sliders.Commands;
using Application.Features.Sliders.Dtos;
using Domain.Entities.App;

namespace Application.Features.Sliders.Profiles;

public class SliderProfile : Profile
{
    public SliderProfile()
    {
        CreateMap<SliderDto, Slider>().ReverseMap();
        CreateMap<CreateSliderCommand, Slider>().ReverseMap();
    }
}
