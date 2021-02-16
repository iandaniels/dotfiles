# Sets the Office 365 update channel to monthly
# https://docs.microsoft.com/en-us/office365/troubleshoot/administration/switch-channel-for-office-365

# if %errorlevel%==0 (goto SwitchChannel) else (goto End)
# :SwitchChannel
# reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v CDNBaseUrl /t REG_SZ /d "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60" /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateUrl /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateToVersion /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Updates /v UpdateToVersion /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\ /f


$baseUrl = "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60"
$regPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\"
$regKey = "CDNBaseUrl"
$updatesPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\"
$officeUpdatePath = "HKLM:\\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\"

if (Test-Path $regPath)
{
    $CDNBaseUrl = Get-ItemProperty $regPath -Name $regKey -ErrorAction SilentlyContinue

    if (! $CDNBaseUrl)
    {
        New-ItemProperty -Name $regKey -Path $regPath -PropertyType string -Value $baseUrl -Force
    }

    if (Get-ItemProperty -Path $regPath -Name "UpdateUrl" -ErrorAction SilentlyContinue)
    {
        Remove-ItemProperty -Path $regPath -Name "UpdateUrl" -Force
    }
    
    if (Get-ItemProperty -Path $regPath -Name "UpdateToVersion" -ErrorAction SilentlyContinue)
    {
        Remove-ItemProperty -Path $regPath -Name "UpdateToVersion" -Force
    }
}

if (Test-Path $updatesPath)
{
    if (Get-ItemProperty -Path $updatesPath -Name "UpdateToVersion" -ErrorAction SilentlyContinue)
    {
        Remove-ItemProperty -Path $updatesPath -Name "UpdateToVersion" -Force
    }
}

if (Test-Path $officeUpdatePath)
{
    Remove-Item -Path $officeUpdatePath -Force
}

$updateCommand = join-path $env:CommonProgramFiles '\Microsoft Shared\ClickToRun\OfficeC2RClient.exe' 

& $updateCommand /update user
