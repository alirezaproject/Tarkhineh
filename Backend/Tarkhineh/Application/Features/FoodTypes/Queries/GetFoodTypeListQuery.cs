using Application.Features.FoodTypes.Dtos;

namespace Application.Features.FoodTypes.Queries;

public record GetFoodTypeListQuery() : IRequest<ApiResult<List<FoodTypeDto>>>;


public class GetFoodTypeListQueryHandler(IDatabaseContext context, IMapper mapper)
    : IRequestHandler<GetFoodTypeListQuery, ApiResult<List<FoodTypeDto>>>
{
    public async Task<ApiResult<List<FoodTypeDto>>> Handle(GetFoodTypeListQuery request, CancellationToken cancellationToken)
    {
        var list = await context.FoodTypes
            .ProjectTo<FoodTypeDto>(mapper.ConfigurationProvider)
            .ToListAsync(cancellationToken);

        return ApiResult<List<FoodTypeDto>>.Ok(list);
    }
}
