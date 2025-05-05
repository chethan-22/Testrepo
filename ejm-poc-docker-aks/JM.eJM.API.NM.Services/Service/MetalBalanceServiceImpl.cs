using JM.eJM.API.NM.DAO;
using JM.eJM.API.NM.DTO.Enums;
using JM.eJM.API.NM.DTO.Model;
using JM.eJM.API.NM.DTO.Response;
using JM.eJM.API.NM.DTO.Utility;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace JM.eJM.API.NM.Services.Service;

public class MetalBalanceServiceImpl : IMetalBalanceService
{
    private readonly NMContext context;
    private readonly ILogger log;
    private bool _disposed;
    public MetalBalanceServiceImpl(NMContext _context, ILogger<MetalBalanceServiceImpl> _log)
    {
        context = _context;
        log = _log;
    }
    /// <summary>
    /// Bring account balance from backend and map to account
    /// </summary>
    /// <param name="accounts">Nobel Metal Account Numbers in array(1233,3434,34343)</param>
    /// <returns></returns>
    public async Task<List<AccountBalanceResponse>> GetMetalAccountBalance(string[] accounts)
    {
        List<AccountBalanceResponse> _accountBalanceResponse = new();

        for (int i = 0; i < accounts.Length; i++)
        {
            AccountBalanceResponse acc = new()
            {
                AccountNumber = accounts[i],
                BalanceList = await GetMetalBalance(accounts[i])
            };
            _accountBalanceResponse.Add(acc);
        }
        return _accountBalanceResponse;

    }
    /// <summary>
    /// Bring metal balance from database
    /// </summary>
    /// <param name="accountNumber">Nobel Metal Account Number</param>
    /// <returns></returns>
    public async Task<List<BalanceDetail>> GetMetalBalance(string accountNumber)
    {
        List<BalanceDetail> metalBalanceResponseList = new();

        try
        {
            List<AccountBalance> _accbal = await GetAccountBalanceData(accountNumber);
            for (int i = 0; i < _accbal.Count; i++)
            {
                BalanceDetail bd = new();
                var value = _accbal[i].Balance;
                bd.Balance = _accbal[i].Uom.ToLower() == "gms" ? Math.Round(value, 2).ToString("0.00") : Math.Round(value, 3).ToString("0.000");
                bd.Metal = EnumUtility.GetEnumMemberAttrValue(typeof(Metal), (_accbal[i].MetalCode));
                bd.Uom = _accbal[i].Uom;
                metalBalanceResponseList.Add(bd);
            }
            return metalBalanceResponseList;
        }
        catch (Exception e)
        {
            log.LogError("Exception in GetMetalBalance -- " + e.Message);
            return metalBalanceResponseList;

        }
    }
    /// <summary>
    /// Bring account balance from database
    /// </summary>
    /// <param name="accountNumber">Nobel Metal Account Number</param>
    /// <returns></returns>
    public async Task<List<AccountBalance>> GetAccountBalanceData(string accountNumber)
    {
        var buaccounts = await (context.AccountBalance
                .Where(x => x.AccountNumber == accountNumber).ToListAsync());
        if (buaccounts.Count == 0)
        {
            log.LogInformation("GetAccountBalanceData - For account number " + accountNumber + " account balance does not exist (or) does not belongs to Nobel Metal Account");
        }
        return buaccounts;
    }
    protected virtual void Dispose(bool disposing)
    {
        if (_disposed)
        {
            return;
        }

        if (disposing)
        {
            context?.Dispose();
        }

        _disposed = true;
    }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
}