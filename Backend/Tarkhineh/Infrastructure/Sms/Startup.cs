using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Sms;

internal static class Startup
{
    internal static IServiceCollection AddSms(this IServiceCollection services, IConfiguration config) =>
        services.Configure<SmsSetting>(config.GetSection(nameof(SmsSetting)));
}