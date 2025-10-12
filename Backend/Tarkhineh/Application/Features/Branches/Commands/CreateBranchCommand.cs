using AutoMapper;
using Domain.Entities.Foods;
using Serilog;
using Shared.Constants;
using Shared.Wrapper;

namespace Application.Features.Branches.Commands;

public class CreateBranchCommand :  IRequest<ApiResult<Guid>>
{
    public string Name { get; set; }
    public string Address { get; set; }
    public string ImageUrl { get; set; }
    public string WorkHours { get; set; }
    public string PhoneNumber { get; set; }
    public double Latitude { get; set; }  // عرض جغرافیایی X
    public double Longitude { get; set; } // طول جغرافیایی Y
}

public class CreateBranchValidator : AbstractValidator<CreateBranchCommand>
{
    public CreateBranchValidator()
    {
        RuleFor(s => s.Name)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نام شعبه");

        // TODO: Complete validator
    }
}


public class CreateBranchCommandHandler(IMapper mapper,ILogger logger,IDatabaseContext context) : IRequestHandler<CreateBranchCommand, ApiResult<Guid>>
{
    public async Task<ApiResult<Guid>> Handle(CreateBranchCommand request, CancellationToken cancellationToken)
    {
        try
        {
            var branch = mapper.Map<Branch>(request);

            await context.Branch.AddAsync(branch, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            logger.Information("Branch created successfully with Id: {Id}", branch.Id);

            return ApiResult<Guid>.CreateSuccess(branch.Id,"شعبه");
        }
        catch (Exception e)
        {
            logger.Error(e,"Error creating Branch: {@Request}",request);

            return ApiResult<Guid>.CreateFailed("شعبه");
        }

    }
}