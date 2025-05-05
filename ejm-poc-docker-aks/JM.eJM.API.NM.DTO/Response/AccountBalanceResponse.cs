using JM.eJM.API.NM.DTO.Model;
using System.Collections.Generic;

namespace JM.eJM.API.NM.DTO.Response;

public class AccountBalanceResponse
{
    public string AccountNumber { get; set; }
    public List<BalanceDetail> BalanceList { get; set; }
 
}
