using Application.Features.Categories.Commands;
using Application.Features.Categories.Queries;
using Microsoft.AspNetCore.Authorization;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class CategoryController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet]
        public async Task<IActionResult> GetAll() => Ok(await mediator.Send(new GetCategoryListQuery()));

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(Guid id)
            => Ok(await mediator.Send(new GetCategoryByIdQuery(id)));

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCategoryCommand command)
            => Ok(await mediator.Send(command));
    }
}
