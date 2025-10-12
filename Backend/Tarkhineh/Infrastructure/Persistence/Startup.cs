using Application.Common.Interfaces;
using Infrastructure.Persistence.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;

namespace Infrastructure.Persistence;

internal static class Startup
{
    internal static IServiceCollection AddPersistence(this IServiceCollection services, IConfiguration config)
    {
        services.AddScoped<IDatabaseContext, DatabaseContext>();
        return services.AddDbContext<DatabaseContext>((sp, options) =>
        {
            var connectionString = config.GetConnectionString("Default");
            options.UseSqlServer(connectionString);
        });
    }
}