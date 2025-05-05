using Azure;
using JM.eJM.API.NM.Services.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace JM.eJM.API.NM.Functions.UnitTests

{
    public class NMAccountBalanceTest : TestStartup
    {

        [Fact]
        public async Task NMAccount_ReturnBalanceDetails()
        {
            try
            {
                var serviceimpltest = (MetalBalanceServiceImpl)TestStartup.service.GetService(typeof(IMetalBalanceService));
                var accountBalanceFunction = new AccountBalance(serviceimpltest);              
                var query = Testhelper.getQuery();
                var logger = Mock.Of<ILogger>();
                query.Add("account", "649");             
                var result = await accountBalanceFunction.Run(req: Testhelper.HttpRequestSetup(query, ""), logger);
                Assert.NotNull(result);
            }
            catch (Exception )
            {
                throw ;
            }
        }

        [Fact]
        public async Task NMAccount_AccountEmpty()
        {
            try
            {
                var serviceimpltest = (MetalBalanceServiceImpl)TestStartup.service.GetService(typeof(IMetalBalanceService));
                var accountBalanceFunction = new AccountBalance(serviceimpltest);
                var query = Testhelper.getQuery();
                var logger = Mock.Of<ILogger>();
                var result = await accountBalanceFunction.Run(req: Testhelper.HttpRequestSetup(query, ""), logger);
                var response = (BadRequestObjectResult)result;
                Assert.NotEqual(200, response.StatusCode);
            }
            catch (Exception)
            {
                throw;
            }
        }


        [Fact]
        public async Task NMAccount_when_account_is_null_ReturnsException()
        {
            try
            {            
                var serviceimpltest = (MetalBalanceServiceImpl)TestStartup.service.GetService(typeof(IMetalBalanceService));
                var userAccountInfoFunction = new AccountBalance(serviceimpltest);
                var logger = Mock.Of<ILogger>();
                var result = await userAccountInfoFunction.Run(req: null, logger);
                var response = (BadRequestObjectResult)result;
                Assert.NotEqual(200, response.StatusCode);
            }
            catch (Exception )
            {
                throw ;
            }
        }

    }
}