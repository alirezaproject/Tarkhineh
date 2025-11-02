using Application.Features.Categories.Dtos;

namespace Application.Features.Categories.Queries;

public class GetCategoriesByFoodTypeIdQuery(Guid foodTypeId) : IRequest<ApiResult<List<CategoryDto>>>
{
    public Guid FoodTypeId { get; } = foodTypeId;
}

public class GetCategoriesByFoodTypeIdQueryHandler(
    IMapper mapper,
    IDatabaseContext context,
    ILogger<GetCategoriesByFoodTypeIdQueryHandler> logger)
    : IRequestHandler<GetCategoriesByFoodTypeIdQuery, ApiResult<List<CategoryDto>>>
{
    public async Task<ApiResult<List<CategoryDto>>> Handle(
        GetCategoriesByFoodTypeIdQuery request,
        CancellationToken cancellationToken)
    {
        try
        {
            var categories = await context.Categories
                .Where(c => c.FoodTypeId == request.FoodTypeId)
                .ProjectTo<CategoryDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);
            return ApiResult<List<CategoryDto>>.Ok(categories);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error fetching categories by FoodTypeId {FoodTypeId}", request.FoodTypeId);
            return ApiResult<List<CategoryDto>>.Fail();
        }
    }
}