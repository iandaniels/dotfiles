# function Get-Temperature {
#     $t = Get-CimInstance MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
#     $returntemp = @()

#     foreach ($temp in $t.CurrentTemperature)
#     {
#         $currentTempKelvin = $temp / 10
#         $currentTempCelsius = $currentTempKelvin - 273.15

#         $returntemp += $(" {0:f2} C : {1:f2} K" -f $currentTempCelsius, $currentTempKelvin)
#     }
#     return $returntemp
# }   

function Get-Temperature {
    $t = Get-CimInstance MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
    $returntemp = @()

    $t | ForEach-Object {
        $currentTempKelvin = $_.CurrentTemperature / 10
        $currentTempCelsius = $currentTempKelvin - 273.15

        $reading = ($_.InstanceName -split '\\')[2].Substring(0,3)
        $returntemp += $("{0} {1:f2} C : {2:f2} K" -f $reading,$currentTempCelsius,$currentTempKelvin)
    }

    return $returntemp
}   

Get-Temperature