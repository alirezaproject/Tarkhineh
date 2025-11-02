using Domain.Entities.Categories;
using Shared.Constants;

namespace Application.Features.Categories.Commands;

public class CreateCategoryCommand : IRequest<ApiResult<Guid>>
{
    public string Name { get; set; }
    public Guid FoodTypeId { get; set; }
}

public class CreateCategoryCommandValidator : AbstractValidator<CreateCategoryCommand>
{
    public CreateCategoryCommandValidator()
    {
        RuleFor(s => s.Name)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نام دسته بندی");

        RuleFor(s => s.FoodTypeId)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نوع غذای دسته بندی");
    }
}

public class CreateCategoryCommandHandler(
    IDatabaseContext context,
    IMapper mapper,
    ILogger<CreateCategoryCommandHandler> logger)
    : IRequestHandler<CreateCategoryCommand, ApiResult<Guid>>
{
    public async Task<ApiResult<Guid>> Handle(
        CreateCategoryCommand request,
        CancellationToken cancellationToken)
    {
        try
        {
            
            var entity = mapper.Map<Category>(request);
            
            await context.Categories.AddAsync(entity, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            return ApiResult<Guid>.CreateSuccess(entity.Id,"دسته بندی");
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error creating category {CategoryName}", request.Name);
            return ApiResult<Guid>.CreateFailed("دسته بندی");
        }
    }
}