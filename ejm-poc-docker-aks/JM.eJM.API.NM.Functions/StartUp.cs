
using JM.eJM.API.NM.Services.Helper;
using JM.eJM.API.NM.Services.Service;
using JM.eJM.API.NM.DAO;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using System;
using System.Diagnostics.CodeAnalysis;

[assembly: FunctionsStartup(typeof(JM.eJM.API.NM.Functions.StartUp))]

namespace JM.eJM.API.NM.Functions;
[ExcludeFromCodeCoverage]
public class StartUp : FunctionsStartup
{
    public IConfiguration Configuration { get; }

    public override void Configure(IFunctionsHostBuilder builder)
    {
        builder.Services.AddDbContext<NMContext>(options =>
        {
            options.UseSqlServer(EjmUtility.GetEnvironmentVariable("ConnectionStrings"), sqlServerOptions => sqlServerOptions.CommandTimeout(Convert.ToInt32(EjmUtility.GetEnvironmentVariable("TIME_OUT"))));
        });
        builder.Services.AddScoped<Func<NMContext>>((provider) => () => provider.GetService<NMContext>());
        builder.Services.AddScoped<IMetalBalanceService, MetalBalanceServiceImpl>();
    }

}
