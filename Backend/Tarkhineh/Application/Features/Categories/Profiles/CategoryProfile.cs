using Application.Features.Categories.Commands;
using Application.Features.Categories.Dtos;
using Domain.Entities.Categories;

namespace Application.Features.Categories.Profiles;

public class CategoryProfile : Profile
{
    public CategoryProfile()
    {
        CreateMap<Category, CategoryDto>().ReverseMap();
        CreateMap<CreateCategoryCommand, Category>();
    }
}