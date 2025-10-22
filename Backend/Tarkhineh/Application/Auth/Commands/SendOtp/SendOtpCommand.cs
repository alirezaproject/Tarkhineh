using Domain.Entities.Users;
using Microsoft.AspNetCore.Identity;
using Shared.Constants;

namespace Application.Auth.Commands.SendOtp;

public record SendOtpCommand(string Phone) : IRequest<ApiResult>;

public class SendOtpCommandValidator : AbstractValidator<SendOtpCommand>
{
    public SendOtpCommandValidator()
    {
        RuleFor(x => x.Phone)
            .NotEmpty().WithMessage(ValidationMessages.Required)
            .Matches(@"^09\d{9}$").WithMessage(ValidationMessages.MobileNumber)
            .WithName("تلفن همراه");
    }
}

public class SendOtpCommandHandler(UserManager<User> userManager, ISmsService smsService)
    : IRequestHandler<SendOtpCommand, ApiResult>
{

    public async Task<ApiResult> Handle(SendOtpCommand request, CancellationToken cancellationToken)
    {
        var user = await userManager.FindByNameAsync(request.Phone);
        if (user == null)
        {
            
            user = new User
            {
                UserName = request.Phone,
                PhoneNumber = request.Phone,
                

            };
          var res =  await userManager.CreateAsync(user);
        }

        var code = await userManager.GenerateChangePhoneNumberTokenAsync(user, request.Phone);

        await smsService.SendAsync(request.Phone, code, 123456);

        return ApiResult.Ok($"کد تایید : {code}");
    }
}