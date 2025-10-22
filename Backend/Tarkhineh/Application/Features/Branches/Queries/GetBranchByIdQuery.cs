using Application.Features.Branches.Dtos;
using Microsoft.Extensions.Logging;
using Shared.Constants;

namespace Application.Features.Branches.Queries;

public record GetBranchByIdQuery(Guid Id) : IRequest<ApiResult<BranchDto>>;


public class GetBranchByIdQueryHandler(
    IDatabaseContext context,
    IMapper mapper,
    ILogger<GetBranchByIdQueryHandler> logger)
    : IRequestHandler<GetBranchByIdQuery, ApiResult<BranchDto>>
{

    public async Task<ApiResult<BranchDto>> Handle(GetBranchByIdQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var branch = await context.Branch
                .Where(b => b.Id == request.Id)
                .ProjectTo<BranchDto>(mapper.ConfigurationProvider)
                .FirstOrDefaultAsync(cancellationToken);

            if (branch == null)
                return ApiResult<BranchDto>.NotFound("شعبه");

            return ApiResult<BranchDto>.Ok(branch);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error fetching branch with Id = {Id}", request.Id);
            return ApiResult<BranchDto>.Fail();
        }
    }
}