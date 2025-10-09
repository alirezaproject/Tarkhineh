namespace Application.Common.Models;

public class SmsIrVerifyRequest
{
    public string Mobile { get; set; }
    public int TemplateId { get; set; } // شناسه قالب در پنل
    public List<VerifyParameter> Parameters { get; set; }
}

public class VerifyParameter
{
    public string Name { get; set; }
    public string Value { get; set; }
}

public class SmsIrVerifyResponse
{
    public int Status { get; set; }
    public string Message { get; set; }
    public object Data { get; set; }
}