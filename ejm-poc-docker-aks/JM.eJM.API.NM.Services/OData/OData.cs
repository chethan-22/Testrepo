using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace JM.eJM.API.NM.Services.OData
{
    public class OData<T>
    {
        [JsonPropertyName("value")]
        public List<T> Value { get; set; }
    }
}
