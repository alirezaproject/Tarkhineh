using Application.Features.Foods.Dtos;

namespace Application.Features.Foods.Queries;

public class GetSpecialFoodListQuery : IRequest<ApiResult<List<FoodDto>>>
{
    
}

public class GetSpecialFoodListQueryHandler(IMapper mapper, IDatabaseContext context, ILogger logger)
    : IRequestHandler<GetSpecialFoodListQuery, ApiResult<List<FoodDto>>>
{
    public async Task<ApiResult<List<FoodDto>>> Handle(GetSpecialFoodListQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var foods = await context.Foods
                .Where(x => x.IsAvailable && x.IsSpecialOffer)
                .ProjectTo<FoodDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<FoodDto>>.Ok(foods);
        }

        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching special food list");

            return ApiResult<List<FoodDto>>.Fail();
        }
    }
}