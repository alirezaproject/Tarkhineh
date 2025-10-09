namespace Shared.Wrapper;

public class ApiResult
{
    public bool Success { get; set; }
    public string? Message { get; set; }

    public static ApiResult Ok( string? message = null)
    {
        return new ApiResult { Success = true, Message = message };
    }

    public static ApiResult Fail(string message)
    {
        return new ApiResult { Success = false, Message = message};
    }
}


public class ApiResult<T> : ApiResult
{
    public T? Data { get; set; }

    public static ApiResult<T> Ok(T? data, string? message = null)
    {
        return new ApiResult<T> { Success = true, Data = data, Message = message };
    }

    public static ApiResult<T> Fail(string message, T? data = default)
    {
        return new ApiResult<T> { Success = false, Message = message, Data = data };
    }
}
