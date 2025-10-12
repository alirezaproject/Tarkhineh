using Application.Features.FoodTypes.Dtos;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Shared.Wrapper;

namespace Application.Features.FoodTypes.Queries;

public record GetFoodTypeByIdQuery(Guid Id) : IRequest<ApiResult<FoodTypeDto>>;


public class GetFoodTypeByIdQueryHandler(IDatabaseContext context, IMapper mapper)
    : IRequestHandler<GetFoodTypeByIdQuery, ApiResult<FoodTypeDto>>
{
    public async Task<ApiResult<FoodTypeDto>> Handle(GetFoodTypeByIdQuery request, CancellationToken cancellationToken)
    {
        var dto = await context.FoodTypes
            .ProjectTo<FoodTypeDto>(mapper.ConfigurationProvider)
            .FirstOrDefaultAsync(f => f.Id == request.Id, cancellationToken);

        if (dto == null)
            return ApiResult<FoodTypeDto>.NotFound("نوع غذا");

        return ApiResult<FoodTypeDto>.Ok(dto);
    }
}
