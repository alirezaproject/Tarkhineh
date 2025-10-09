using Infrastructure.Sms;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Auth;

internal static class Startup
{
    internal static IServiceCollection AddJwt(this IServiceCollection services, IConfiguration config) =>
        services.Configure<JwtSetting>(config.GetSection(nameof(JwtSetting)));
}