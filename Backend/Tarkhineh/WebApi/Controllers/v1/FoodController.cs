using Application.Features.Foods.Commands;
using Application.Features.Foods.Queries;
using Microsoft.AspNetCore.Http;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class FoodController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet]
        public async Task<IActionResult> GetList()
        {
            return Ok(await mediator.Send(new GetFoodListQuery()));
        }


        [HttpPost]
        public async Task<IActionResult> CreateFood(CreateFoodCommand command)
        {
            return Ok(await mediator.Send(command));
        }
    }
}
