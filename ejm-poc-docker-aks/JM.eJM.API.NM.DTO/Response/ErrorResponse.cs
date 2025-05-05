using Newtonsoft.Json;

namespace JM.eJM.API.NM.DTO.Response;

public class ErrorResponse
{
    public int StatusCode { get; set; }
    public string Message { get; set; }
    public override string ToString()
    {
        return JsonConvert.SerializeObject(this);
    }
}
