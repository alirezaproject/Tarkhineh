using Application.Auth.Commands.RefreshToken;
using Application.Auth.Commands.SendOtp;
using Application.Auth.Commands.VerifyOtp;
using WebApi.Models;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class AuthController(IMediator mediator) : BaseController(mediator)
    {
        [HttpPost("send-otp")]
        public async Task<IActionResult> SendOtp([FromBody] SendOtpCommand request)
        {
            var result = await mediator.Send(new SendOtpCommand(request.Phone));
            return Ok(result);
        }

        [HttpPost("verify-otp")]
        public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpCommand command)
        {
            var result = await mediator.Send(command);
            return Ok(result);
        }


        [HttpPost("refresh")]
        public async Task<IActionResult> Refresh([FromBody] RefreshTokenRequest request)
        {
            var result = await mediator.Send(new RefreshTokenCommand(request.RefreshToken));
            return Ok(result);
        }


    }
}
