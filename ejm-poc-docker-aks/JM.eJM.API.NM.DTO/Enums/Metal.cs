using System.Runtime.Serialization;

namespace JM.eJM.API.NM.DTO.Enums;

public enum Metal
{

    [EnumMember(Value = "Gold")]
    AU,
    [EnumMember(Value = "Copper")]
    CU,
    [EnumMember(Value = "Zinc")]
    ZN,
    [EnumMember(Value = "Nickel")]
    NI,
    [EnumMember(Value = "Silver")]
    AG,
    [EnumMember(Value = "Rhenium")]
    RE,
    [EnumMember(Value = "Osmium")]
    OS,
    [EnumMember(Value = "Iridium")]
    IR,
    [EnumMember(Value = "Ruthenium")]
    RU,
    [EnumMember(Value = "Rhodium")]
    RH,
    [EnumMember(Value = "Palladium")]
    PD,
    [EnumMember(Value = "Platinum")]
    PT,
}