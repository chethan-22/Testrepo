using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using JM.eJM.API.NM.Services.Service;
using JM.eJM.API.NM.DTO.Response;
using JM.eJM.API.NM.Services.OData;
using System;
using System.Net;

namespace JM.eJM.API.NM.Functions
{
    public class AccountBalance
    {
        private readonly IMetalBalanceService metalBalanceService;

        public AccountBalance(IMetalBalanceService _metalBalanceService)
        {
            metalBalanceService = _metalBalanceService;
        }

        /// <summary>
        /// This function brings account balance for Nobel Metal accounts
        /// </summary>
        /// <param name="req"></param>
        /// <param name="log"></param>
        /// <returns></returns>
        [FunctionName("AccountBalance")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req,
            ILogger log)
        {
            try
            {
                log.LogInformation("NMAccountBalance API Started");

                string[] accounts = null;
                var response = new OData<AccountBalanceResponse>();

                if (!String.IsNullOrEmpty(req.Query["account"]))
                {
                    accounts = req.Query["account"].ToString().Split(",");
                    if (accounts != null)
                    {
                        response.Value = await metalBalanceService.GetMetalAccountBalance(accounts);
                    }
                }
                else
                {

                    throw new ArgumentNullException(nameof(req), "Account Number is empty");
                }

                return new OkObjectResult(response.Value);

            }
            catch (Exception ex)
            {
                log.LogError(ex.Message);
                return new BadRequestObjectResult(new ErrorResponse() { Message = ex.Message, StatusCode = (int)HttpStatusCode.InternalServerError });
            }
            finally
            {
                metalBalanceService.Dispose();
            }
        }
    }
}
