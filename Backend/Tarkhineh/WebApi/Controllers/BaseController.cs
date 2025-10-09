using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers;

[ApiController]
public class BaseController(IMediator mediator) : Controller
{

}