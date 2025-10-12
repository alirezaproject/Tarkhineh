using Application.Features.Sliders.Dtos;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Shared.Wrapper;

namespace Application.Features.Sliders.Queries;

public class GetSliderListQuery : IRequest<ApiResult<List<SliderDto>>> { }


public  class GetSliderListQueryHandler(IDatabaseContext context,IMapper mapper,ILogger logger) : IRequestHandler<GetSliderListQuery, ApiResult<List<SliderDto>>>
{
    public async Task<ApiResult<List<SliderDto>>> Handle(GetSliderListQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var sliders = await context.Sliders
                .ProjectTo<SliderDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<SliderDto>>.Ok(sliders);
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching slider list.");
            return ApiResult<List<SliderDto>>.Fail();
        }
    }
}