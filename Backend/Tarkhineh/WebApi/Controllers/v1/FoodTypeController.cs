using Application.Features.FoodTypes.Commands;
using Application.Features.FoodTypes.Dtos;
using Application.Features.FoodTypes.Queries;
using Microsoft.AspNetCore.Authorization;
using Shared.Wrapper;

namespace WebApi.Controllers.v1
{
    
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [Authorize]
    public class FoodTypeController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet("{id}")]
        public async Task<ApiResult<FoodTypeDto>> GetById(Guid id)
            => await mediator.Send(new GetFoodTypeByIdQuery(id));

        [HttpGet]
        public async Task<ApiResult<List<FoodTypeDto>>> GetList()
            => await mediator.Send(new GetFoodTypeListQuery());

        [HttpPost]
        [Authorize]
        public async Task<ApiResult<Guid>> Create(CreateFoodTypeCommand command)
            => await mediator.Send(command);

    }
}
