using System;

namespace JM.eJM.API.NM.Services.Helper
{
    public static class EjmUtility
    {
        /// <summary>
        /// Brings environment variables from config file
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public static string GetEnvironmentVariable(string name)
        {
            return Environment.GetEnvironmentVariable(name, EnvironmentVariableTarget.Process);
        }
    }
}
