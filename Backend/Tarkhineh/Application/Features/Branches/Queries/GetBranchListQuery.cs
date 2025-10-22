using Application.Features.Branches.Dtos;

namespace Application.Features.Branches.Queries;

public class GetBranchListQuery: IRequest<ApiResult<List<BranchDto>>>
{
    
}


public class GetBranchListQueryHandler(IMapper mapper, IDatabaseContext context, ILogger logger)
    : IRequestHandler<GetBranchListQuery, ApiResult<List<BranchDto>>>
{
    

    public async Task<ApiResult<List<BranchDto>>> Handle(GetBranchListQuery request, CancellationToken cancellationToken)
    {
        try
        {
            var branches = await context.Branch
                .ProjectTo<BranchDto>(mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return ApiResult<List<BranchDto>>.Ok(branches);
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error fetching branch list");

            return ApiResult<List<BranchDto>>.Fail();
        }
    }
}

