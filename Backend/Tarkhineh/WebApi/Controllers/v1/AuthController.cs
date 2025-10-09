using Application.Auth.Commands.SendOtp;
using Application.Auth.Commands.VerifyOtp;
using Microsoft.AspNetCore.Mvc;
using System.Numerics;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Authorization;
using Shared.Wrapper;

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


        [Authorize]
        [HttpGet("test")]
        public async Task<IActionResult> Test()
        {
            var api = ApiResult.Ok("test");
            
            return Ok(api);
        }
    }
}
