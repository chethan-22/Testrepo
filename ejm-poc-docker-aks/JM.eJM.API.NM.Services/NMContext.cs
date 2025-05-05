using JM.eJM.API.NM.Services.Helper;
using JM.eJM.API.NM.DTO.Model;
using Microsoft.EntityFrameworkCore;
using System;

namespace JM.eJM.API.NM.DAO
{

    public partial class NMContext : DbContext
    {
        public NMContext()
        {
        }

        public NMContext(DbContextOptions<NMContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AccountBalance> AccountBalance { get; set; }
       
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(EjmUtility.GetEnvironmentVariable("ConnectionStrings"), sqlServerOptions => sqlServerOptions.CommandTimeout(Convert.ToInt32(EjmUtility.GetEnvironmentVariable("TIME_OUT"))));

            }
        }
        /// <summary>
        /// Nobel Metal Account Balance Database View
        /// </summary>
        /// <param name="modelBuilder"></param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
           
            modelBuilder.Entity<AccountBalance>(entity =>
               {                  
                    entity.ToView("vw_MetalBalance_NM").HasNoKey();                   
               });           
        }
    }
}
