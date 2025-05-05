using System.Runtime.Serialization;
using System;
using System.Linq;

namespace JM.eJM.API.NM.DTO.Utility;

public static class EnumUtility
{
    /// <summary>
    /// This enum give metal name based on metal code
    /// </summary>
    /// <param name="enumType">XPT</param>
    /// <param name="enumVal">Platinum</param>
    /// <returns></returns>
    public static string GetEnumMemberAttrValue(Type enumType, object enumVal)
    {
        var memInfo = enumType.GetMember(enumVal.ToString());
        var attr = memInfo[0].GetCustomAttributes(false).OfType<EnumMemberAttribute>().FirstOrDefault();
        if (attr != null)
        {
            return attr.Value;
        }
        return null;
    }
}
