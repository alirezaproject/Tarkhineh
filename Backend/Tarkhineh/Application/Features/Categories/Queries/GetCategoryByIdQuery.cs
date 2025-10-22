using Application.Features.Categories.Dtos;
using Microsoft.Extensions.Logging;

namespace Application.Features.Categories.Queries;

public class GetCategoryByIdQuery(Guid id) : IRequest<ApiResult<CategoryDto>>
{
    public Guid Id { get; } = id;
}


public class GetCategoryByIdQueryHandler(
    IMapper mapper,
    IDatabaseContext context,
    ILogger<GetCategoryByIdQueryHandler> logger)
    : IRequestHandler<GetCategoryByIdQuery, ApiResult<CategoryDto>>
{
    public async Task<ApiResult<CategoryDto>> Handle(
        GetCategoryByIdQuery request,
        CancellationToken cancellationToken)
    {
        try
        {
            var category = await context.Categories
                .Where(c => c.Id == request.Id)
                .ProjectTo<CategoryDto>(mapper.ConfigurationProvider)
                .FirstOrDefaultAsync(cancellationToken);

            if (category is null)
                return ApiResult<CategoryDto>.NotFound("دسته بندی");

            return ApiResult<CategoryDto>.Ok(category);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error fetching category by ID {CategoryId}", request.Id);
            return ApiResult<CategoryDto>.Fail();
        }
    }
}
