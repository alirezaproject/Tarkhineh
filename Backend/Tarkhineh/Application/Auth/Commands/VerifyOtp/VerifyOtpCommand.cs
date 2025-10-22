using Application.Common.Responses;
using Domain.Entities.Users;
using Microsoft.AspNetCore.Identity;
using Shared.Constants;

namespace Application.Auth.Commands.VerifyOtp;

public record VerifyOtpCommand(string Mobile,string Code) :IRequest<ApiResult<JwtResponse>>;


public class VerifyOtpCommandHandler(UserManager<User> userManager, IJwtService jwtService)
    : IRequestHandler<VerifyOtpCommand, ApiResult<JwtResponse>>
{
    public async Task<ApiResult<JwtResponse>> Handle(VerifyOtpCommand request, CancellationToken cancellationToken)
    {
        var user = await userManager.FindByNameAsync(request.Mobile);
        if (user is null)
            return ApiResult<JwtResponse>.Fail(ErrorMessages.UserNotFound);

        var isValid = await userManager.VerifyChangePhoneNumberTokenAsync(user, request.Code, request.Mobile);
        if (!isValid)
            return ApiResult<JwtResponse>.Fail(ErrorMessages.InvalidOtp);

        user.PhoneNumberConfirmed = true;
        user.PhoneNumber = request.Mobile;

        user.RefreshToken = jwtService.GenerateRefreshToken();
        user.RefreshTokenExpiryTime = DateTime.UtcNow.AddDays(7);
        
        await userManager.UpdateAsync(user);

      
        var token = jwtService.GenerateToken(user);

        return ApiResult<JwtResponse>.Ok(new JwtResponse(token,user.RefreshToken));
    }
}