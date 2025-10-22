using Domain.Entities.Categories;
using Domain.Entities.Foods;
using Shared.Constants;

namespace Application.Features.Foods.Commands;

public class CreateFoodCommand : IRequest<ApiResult<Guid>>
{
    public string Name { get; set; }
    public string Ingredients { get; set; }
    public string ImageUrl { get; set; }
    public int Price { get; set; }
    public int? DiscountPercent { get; set; }
    public bool IsAvailable { get; set; }
    public bool IsSpecialOffer { get; set; }
    public Guid FoodTypeId { get; set; }
    public List<Guid> CategoryIds { get; set; }
}

public class CreateFoodCommandValidator : AbstractValidator<CreateFoodCommand>
{
    public CreateFoodCommandValidator()
    {
        RuleFor(s => s.Name)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نام غذا");

        RuleFor(s => s.Ingredients)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("ترکیبات");

        RuleFor(s => s.ImageUrl)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .Must(url => Uri.IsWellFormedUriString(url, UriKind.Absolute))
            .WithMessage(ValidationMessages.InvalidFormat)
            .WithName("آدرس تصویر");

        RuleFor(s => s.Price)
            .GreaterThan(0).WithMessage(ValidationMessages.GreaterThanZero)
            .WithName("قیمت");

        RuleFor(s => s.DiscountPercent)
            .InclusiveBetween(0, 100).When(s => s.DiscountPercent.HasValue)
            .WithMessage(ValidationMessages.InvalidRange)
            .WithName("درصد تخفیف");

        RuleFor(s => s.FoodTypeId)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("نوع غذا");

        RuleFor(s => s.CategoryIds)
            .NotNull().WithMessage(ValidationMessages.Required)
            .Must(list => list != null && list.Any())
            .WithMessage(ValidationMessages.AtLeastOneItem)
            .WithName("دسته‌بندی‌ها");

        RuleFor(s => s.IsAvailable)
            .NotNull().WithMessage(ValidationMessages.Required)
            .WithName("وضعیت موجود بودن");

        RuleFor(s => s.IsSpecialOffer)
            .NotNull().WithMessage(ValidationMessages.Required)
            .WithName("پیشنهاد ویژه");
    }
}


public class CreateFoodCommandHandler(IDatabaseContext context, IMapper mapper, ILogger logger)
    : IRequestHandler<CreateFoodCommand, ApiResult<Guid>>
{
    public async Task<ApiResult<Guid>> Handle(CreateFoodCommand request, CancellationToken cancellationToken)
    {
        try
        {
            var food = mapper.Map<Food>(request);
            food.CreatedAt = DateTime.UtcNow;
            food.UpdatedAt = DateTime.UtcNow;

            if (request.CategoryIds.Any())
            {
                food.FoodCategories = request.CategoryIds
                    .Select(id => new FoodCategory
                    {
                        FoodId = food.Id,
                        CategoryId = id
                    })
                    .ToList();
            }

            await context.Foods.AddAsync(food, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            logger.Information("New food created: {FoodId} - {Name}", food.Id, food.Name);

            return ApiResult<Guid>.CreateSuccess(food.Id,"غذا");
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error while creating food");
            return ApiResult<Guid>.CreateFailed("غذا");
        }

    }
}
