namespace Application.Common.Interfaces;

public interface ISmsService : ITransientService
{
    Task<bool> SendAsync(string mobile, string code, int templateId);
}