using Application.Features.Categories.Commands;
using Application.Features.Categories.Queries;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class CategoryController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet]
        public async Task<IActionResult> GetAll() => Ok(await mediator.Send(new GetCategoryListQuery()));

        [HttpGet("{id:guid}")]
        public async Task<IActionResult> GetById(Guid id)
            => Ok(await mediator.Send(new GetCategoryByIdQuery(id)));

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCategoryCommand command)
            => Ok(await mediator.Send(command));


        [HttpGet("getByFoodTypeId/{foodTypeId:guid}")]
        public async Task<IActionResult> GetCategoriesByFoodTypeId(Guid foodTypeId)
            => Ok(await mediator.Send(new GetCategoriesByFoodTypeIdQuery(foodTypeId)));
    }
}
