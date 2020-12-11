rem Sets the Office 365 update channel to monthly
rem https://docs.microsoft.com/en-us/office365/troubleshoot/administration/switch-channel-for-office-365

#setlocal
#reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\ /v CDNBaseUrl

$baseUrl = "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60"
$regPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\"
$regKey = "CDNBaseUrl"

if (Test-Path $regPath)
{
    $CDNBaseUrl = Get-ItemProperty $regPath -Name $regKey -ErrorAction SilentlyContinue

    if (! $CDNBaseUrl)
    {
        New-ItemProperty -Name $regKey -Path $regPath -PropertyType string -Value $baseUrl -Force
    }

    Remove-ItemProperty -Path $regPath -Value "UpdateUrl" -Force
    Remove-ItemProperty -Path $regPath -Value "UpdateToVersion" -Force
}

if (Test-Path HKLM:\\)


if %errorlevel%==0 (goto SwitchChannel) else (goto End)
:SwitchChannel
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v CDNBaseUrl /t REG_SZ /d "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60" /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateUrl /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateToVersion /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Updates /v UpdateToVersion /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\ /f

"%CommonProgramFiles%\microsoft shared\ClickToRun\OfficeC2RClient.exe" /update user
:End
Endlocal 