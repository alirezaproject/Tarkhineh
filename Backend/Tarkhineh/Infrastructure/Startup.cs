using Infrastructure.Auth;
using Infrastructure.Common;
using Infrastructure.Identity;
using Infrastructure.Persistence;
using Infrastructure.Sms;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure;

public static class Startup
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration config)
    {
        return services
           
            .AddPersistence(config)
            .AddSms(config)
            .AddJwt(config)
            .AddIdentity()
            .AddHttpClient()
            .AddServices();
    }



}