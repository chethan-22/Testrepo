using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using JM.eJM.API.NM.DAO;
using JM.eJM.API.NM.Services.Service;
using Microsoft.EntityFrameworkCore;
using JM.eJM.API.NM.Services.Helper;


namespace JM.eJM.API.NM.Functions.UnitTests
{
    public class TestStartup
    {
        public static ServiceProvider? service;
        protected TestStartup()
        {
            Environment.SetEnvironmentVariable("ConnectionStrings", "Server=tcp:sql-svr-dev-ejm-001.database.windows.net,1433;Initial Catalog=sql-db-dev-ejm-001;Persist Security Info=False;User ID=readonlyazure;Password=Extract1!;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            Host.CreateDefaultBuilder()
                       .ConfigureServices((context, services) =>
                       {
                           services.AddDbContext<NMContext>(options =>
                           {
                               options.UseSqlServer(EjmUtility.GetEnvironmentVariable("ConnectionStrings"));

                           });
                           services.AddTransient<Func<NMContext>>((serviceprovider) => () => serviceprovider.GetService<NMContext>());
                           services.AddTransient<IMetalBalanceService, MetalBalanceServiceImpl>();                          
                           service = services.BuildServiceProvider();
                       }).Build();
        }
    }
}
