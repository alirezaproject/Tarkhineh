using Application.Features.Branches.Commands;
using Application.Features.Branches.Queries;
using Microsoft.AspNetCore.Authorization;

namespace WebApi.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class BranchController(IMediator mediator) : BaseController(mediator)
    {
        [HttpGet]
        public async Task<IActionResult> GetBranchList()
        {
            var branches =await mediator.Send(new GetBranchListQuery());
            return Ok(branches);
        }


        [HttpGet("{id:guid}")]
        public async Task<IActionResult> GetBranchById(Guid id)
        {
            var branch = await mediator.Send(new GetBranchByIdQuery(id));
            return Ok(branch);
        }

        [HttpPost]
        public async Task<IActionResult> CreateBranch([FromBody] CreateBranchCommand command)
        {
            return Ok(await mediator.Send(command));
        }

    }
}
