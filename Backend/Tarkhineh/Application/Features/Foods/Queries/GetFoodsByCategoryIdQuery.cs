using Application.Features.Foods.Dtos;

namespace Application.Features.Foods.Queries;

public class GetFoodsByCategoryIdQuery (Guid categoryId) : IRequest<ApiResult<List<FoodDto>>>
{
    public Guid CategoryId { get; } = categoryId;
}

public class GetFoodsByCategoryIdQueryHandler(
    IMapper mapper,
    IDatabaseContext context,
    ILogger<GetFoodsByCategoryIdQueryHandler> logger)
    : IRequestHandler<GetFoodsByCategoryIdQuery, ApiResult<List<FoodDto>>>
{
    public async Task<ApiResult<List<FoodDto>>> Handle(
        GetFoodsByCategoryIdQuery request,
        CancellationToken cancellationToken)
    {
        try
        {
            var foods = await context.Foods
                .Include(c => c.FoodCategories)
                .Where(f => f.FoodCategories.Any(c => c.CategoryId == request.CategoryId))
                .ProjectTo<FoodDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);
            return ApiResult<List<FoodDto>>.Ok(foods);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error fetching foods by CategoryId {CategoryId}", request.CategoryId);
            return ApiResult<List<FoodDto>>.Fail();
        }
    }
}