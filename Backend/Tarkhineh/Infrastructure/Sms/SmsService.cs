using System.Net.Http.Json;
using Application.Common.Interfaces;
using Application.Common.Models;

using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace Infrastructure.Sms;

public class SmsService(IOptions<SmsSetting> options, HttpClient httpClient, ILogger<SmsService> logger)
    : ISmsService
{
    private readonly SmsSetting _settings = options.Value;


    public async Task<bool> SendAsync(string mobile, string code, int templateId)
    {
        try
        {
            var request = new SmsIrVerifyRequest
            {
                Mobile = mobile,
                TemplateId = templateId,
                Parameters = [new VerifyParameter { Name = "Code", Value = code }]
            };

            httpClient.DefaultRequestHeaders.Clear();
            httpClient.DefaultRequestHeaders.Add("x-api-key", _settings.Key);

            var response = await httpClient.PostAsJsonAsync("https://api.sms.ir/v1/send/verify", request);
            if (!response.IsSuccessStatusCode)
                return false;

            var result = await response.Content.ReadFromJsonAsync<SmsIrVerifyResponse>();
            return result is { Status: 1 };
        }
        catch (Exception ex)
        {
            logger.LogError(ex, ex.Message);
            return false;
        }
    }
}