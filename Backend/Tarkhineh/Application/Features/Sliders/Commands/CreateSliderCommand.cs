using AutoMapper;
using Domain.Entities.App;
using Microsoft.EntityFrameworkCore;
using Serilog;
using Shared.Constants;
using Shared.Wrapper;

namespace Application.Features.Sliders.Commands;

public class CreateSliderCommand : IRequest<ApiResult<Guid>>
{
    public string Title { get; set; }
    public string ImageUrl { get; set; }
}

public class SliderCreateValidator : AbstractValidator<CreateSliderCommand>
{
    public SliderCreateValidator()
    {
        RuleFor(s => s.Title)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("عنوان");

        RuleFor(s => s.ImageUrl)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .WithName("آدرس تصویر");
    }
}


public class CreateSliderCommandHandler(ILogger logger,IDatabaseContext context,IMapper mapper) : IRequestHandler<CreateSliderCommand, ApiResult<Guid>>
{
    public async Task<ApiResult<Guid>> Handle(CreateSliderCommand request, CancellationToken cancellationToken)
    {
        try
        {
            var slider = mapper.Map<Slider>(request);
            await context.Sliders.AddAsync(slider, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            logger.Information("Slider created successfully with Id: {Id}", slider.Id);
            return ApiResult<Guid>.CreateSuccess(slider.Id, "اسلایدر");
        }
        catch (Exception ex)
        {
            logger.Error(ex, "Error creating Slider: {@Request}", request);
            return ApiResult<Guid>.CreateFailed("اسلایدر");
        }

    }
}