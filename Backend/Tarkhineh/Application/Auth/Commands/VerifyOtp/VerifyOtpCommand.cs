using Domain.Entities.Users;
using Microsoft.AspNetCore.Identity;
using Shared.Constants;
using Shared.Wrapper;

namespace Application.Auth.Commands.VerifyOtp;

public record VerifyOtpCommand(string Mobile,string Code) :IRequest<ApiResult>;


public class VerifyOtpCommandHandler(UserManager<User> userManager, IJwtService jwtService)
    : IRequestHandler<VerifyOtpCommand, ApiResult>
{
    public async Task<ApiResult> Handle(VerifyOtpCommand request, CancellationToken cancellationToken)
    {
        var user = await userManager.FindByNameAsync(request.Mobile);
        if (user is null)
            return ApiResult.Fail(ErrorMessages.UserNotFound);

        var isValid = await userManager.VerifyChangePhoneNumberTokenAsync(user, request.Code, request.Mobile);
        if (!isValid)
            return ApiResult.Fail(ErrorMessages.InvalidOtp);

        user.PhoneNumberConfirmed = true;
        user.PhoneNumber = request.Mobile;
        await userManager.UpdateAsync(user);

        var roles = await userManager.GetRolesAsync(user);
        var token = jwtService.GenerateToken(user.Id, user.UserName!, roles.ToArray());

        return ApiResult.Ok(token);
    }
}