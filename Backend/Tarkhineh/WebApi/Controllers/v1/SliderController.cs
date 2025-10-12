using Application.Features.Sliders.Commands;
using Application.Features.Sliders.Queries;
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class SliderController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet]
        public async Task<IActionResult> GetAll() => Ok(await mediator.Send(new GetSliderListQuery()));

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(Guid id)
            => Ok(await mediator.Send(new GetSliderByIdQuery { Id = id }));

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateSliderCommand command)
            => Ok(await mediator.Send(command));
    }
}
