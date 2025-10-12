using Application.Features.FoodTypes.Dtos;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Shared.Wrapper;

namespace Application.Features.FoodTypes.Queries;

public record GetFoodTypeListQuery() : IRequest<ApiResult<List<FoodTypeDto>>>;


public class GetFoodTypeListQueryHandler(IDatabaseContext context, IMapper mapper)
    : IRequestHandler<GetFoodTypeListQuery, ApiResult<List<FoodTypeDto>>>
{
    public async Task<ApiResult<List<FoodTypeDto>>> Handle(GetFoodTypeListQuery request, CancellationToken cancellationToken)
    {
        var list = await context.FoodTypes
            .ProjectTo<FoodTypeDto>(mapper.ConfigurationProvider)
            .OrderBy(f => f.Name)
            .ToListAsync(cancellationToken);

        return ApiResult<List<FoodTypeDto>>.Ok(list);
    }
}
