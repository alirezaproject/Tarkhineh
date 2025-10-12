using Application.Features.Sliders.Dtos;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Shared.Wrapper;

namespace Application.Features.Sliders.Queries;

public class GetSliderByIdQuery : IRequest<ApiResult<SliderDto>>
{
    public Guid Id { get; set; }
}

public class GetSliderByIdQueryHandler(IDatabaseContext context,IMapper mapper,ILogger logger) : IRequestHandler<GetSliderByIdQuery, ApiResult<SliderDto>>
{
    public async Task<ApiResult<SliderDto>> Handle(GetSliderByIdQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var slider = await context.Sliders
                .ProjectTo<SliderDto>(mapper.ConfigurationProvider)
                .FirstOrDefaultAsync(s => s.Id == request.Id, cancellationToken);

            if (slider == null)
                return ApiResult<SliderDto>.NotFound("اسلایدر");

            return ApiResult<SliderDto>.Ok(slider);
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching slider with Id {Id}", request.Id);
            return ApiResult<SliderDto>.Fail();
        }
    }
}