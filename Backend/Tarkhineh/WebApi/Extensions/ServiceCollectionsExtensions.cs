using Microsoft.AspNetCore.Mvc;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Reflection;
using System.Text;
using Infrastructure.Auth;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;


namespace WebApi.Extensions;

internal static class ServiceCollectionsExtensions
{
    internal static IServiceCollection RegisterWebApi(this IServiceCollection service, WebApplicationBuilder builder)
    {
        service.AddAuthentication(options =>
        {
            options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
        }).AddJwtBearer(options =>
        {
            options.SaveToken = true;
            options.RequireHttpsMetadata = false;
            options.TokenValidationParameters = new TokenValidationParameters();
            var settings = builder.Configuration.GetSection("JwtSetting").Get<JwtSetting>() 
                           ?? throw new InvalidOperationException("JwtSetting config is missing"); ;
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidIssuer = settings!.Issuer,
                ValidateAudience = true,
                ValidAudience = settings!.Audience,
                ValidateLifetime = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(settings!.Secret)),
                ValidateIssuerSigningKey = true
            };
        });
        builder.Services.AddAuthorization();

        service.AddSwaggerGen(s =>
        {
            //s.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory,"ShablonMedia.xml"),true);
            s.SwaggerDoc("v1", new OpenApiInfo { Title = "Tarkhineh", Version = "v1" });
            s.DocInclusionPredicate((doc, apiDescription) =>
            {
                if (!apiDescription.TryGetMethodInfo(out var methodInfo)) return false;

                var version = methodInfo.DeclaringType!
                    .GetCustomAttributes<ApiVersionAttribute>(true)
                    .SelectMany(attr => attr.Versions);

                return version.Any(v => $"v{v}" == doc);
            });

            s.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                Name = "Authorization",
                Type = SecuritySchemeType.ApiKey,
                Scheme = JwtBearerDefaults.AuthenticationScheme,
                BearerFormat = "JWT",
                In = ParameterLocation.Header,
                Description = "Enter 'Bearer' followed by your JWT token.\nExample: Bearer eyJhbGciOiJIUzI1NiIs..."
            });

            // Apply security to all endpoints
            s.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecurityScheme
                    {
                        Reference = new OpenApiReference
                        {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                        }
                    },
                    Array.Empty<string>()
                }
            });
        });

        service.AddApiVersioning(s =>
        {
            s.AssumeDefaultVersionWhenUnspecified = true;
            s.ReportApiVersions = true;
            s.DefaultApiVersion = new ApiVersion(1, 0);
        });


        return service;
    }
}