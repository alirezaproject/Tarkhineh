using Application.Features.Categories.Dtos;
using Microsoft.Extensions.Logging;

namespace Application.Features.Categories.Queries;

public class GetCategoryListQuery : IRequest<ApiResult<List<CategoryDto>>>;


public class GetCategoryListQueryHandler(
    IMapper mapper,
    IDatabaseContext context,
    ILogger<GetCategoryListQueryHandler> logger)
    : IRequestHandler<GetCategoryListQuery, ApiResult<List<CategoryDto>>>
{
    public async Task<ApiResult<List<CategoryDto>>> Handle(
        GetCategoryListQuery request,
        CancellationToken cancellationToken)
    {
        try
        {
            var categories = await context.Categories
                .ProjectTo<CategoryDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<CategoryDto>>.Ok(categories);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error fetching category list");
            return ApiResult<List<CategoryDto>>.Fail();
        }
    }
}