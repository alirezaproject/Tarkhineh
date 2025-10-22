using Application.Features.Foods.Dtos;

namespace Application.Features.Foods.Queries;

public class GetFoodListQuery : IRequest<ApiResult<List<FoodDto>>>
{

}


public class GetFoodListQueryHandler(IMapper mapper, IDatabaseContext context, ILogger logger)
    : IRequestHandler<GetFoodListQuery, ApiResult<List<FoodDto>>>
{
    public async Task<ApiResult<List<FoodDto>>> Handle(GetFoodListQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var foods = await context.Foods
                .ProjectTo<FoodDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<FoodDto>>.Ok(foods);
        }

        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching food list");

            return ApiResult<List<FoodDto>>.Fail();
        }
    }
}