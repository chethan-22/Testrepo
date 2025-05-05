using JM.eJM.API.NM.DTO.Response;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace JM.eJM.API.NM.Services.Service;

public interface IMetalBalanceService:IDisposable
{
    public Task<List<AccountBalanceResponse>> GetMetalAccountBalance(string[] accounts);

}
