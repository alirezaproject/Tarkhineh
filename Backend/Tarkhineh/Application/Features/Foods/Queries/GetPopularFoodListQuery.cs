using Application.Features.Foods.Dtos;

namespace Application.Features.Foods.Queries;

public class GetPopularFoodListQuery : IRequest<ApiResult<List<FoodDto>>>
{
    
}


public class GetPopularFoodListQueryHandler(IMapper mapper, IDatabaseContext context, ILogger logger)
    : IRequestHandler<GetPopularFoodListQuery, ApiResult<List<FoodDto>>>
{
    public async Task<ApiResult<List<FoodDto>>> Handle(GetPopularFoodListQuery request, CancellationToken cancellationToken)
    {
        try
        {
            
            var foods = await context.Foods
                .Where(x => x.IsAvailable) // TODO : POPULAR FOODS LOGIC
                .ProjectTo<FoodDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<FoodDto>>.Ok(foods);
        }

        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching popular food list");

            return ApiResult<List<FoodDto>>.Fail();
        }
    }
}