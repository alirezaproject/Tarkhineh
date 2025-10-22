using Domain.Entities.Foods;
using Shared.Constants;

namespace Application.Features.FoodTypes.Commands;

public record CreateFoodTypeCommand(string Name, string ImageUrl) : IRequest<ApiResult<Guid>>;

public class CreateFoodTypeCommandValidator : AbstractValidator<CreateFoodTypeCommand>
{
    public CreateFoodTypeCommandValidator()
    {
        RuleFor(s => s.Name)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نوع غذا");

        RuleFor(s => s.ImageUrl)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("آدرس تصویر");
    }
}

public class CreateFoodTypeCommandHandler(IDatabaseContext context, IMapper mapper)
    : IRequestHandler<CreateFoodTypeCommand, ApiResult<Guid>>
{
    

    public async Task<ApiResult<Guid>> Handle(CreateFoodTypeCommand request, CancellationToken cancellationToken)
    {
        var entity = new FoodType
        {
            Name = request.Name,
            ImageUrl = request.ImageUrl,
        };

        context.FoodTypes.Add(entity);
        await context.SaveChangesAsync(cancellationToken);

        return ApiResult<Guid>.CreateSuccess(entity.Id,"نوع غذا");
    }
}
