# Sets the Office 365 update channel to monthly
# https://docs.microsoft.com/en-us/office365/troubleshoot/administration/switch-channel-for-office-365

# if %errorlevel%==0 (goto SwitchChannel) else (goto End)
# :SwitchChannel
# reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v CDNBaseUrl /t REG_SZ /d "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60" /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateUrl /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateToVersion /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Updates /v UpdateToVersion /f
# reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\ /f

# Monthly Enterprise Channel
# CDNBaseUrl = http://officecdn.microsoft.com/pr/55336b82-a18d-4dd6-b5f6-9e5095c314a6 

# Current Channel 
# CDNBaseUrl = http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60

# Current Channel (Preview)
# CDNBaseUrl = http://officecdn.microsoft.com/pr/64256afe-f5d9-4f86-8936-8840a6a4f5be

# Semi-Annual Enterprise Channel 
# CDNBaseUrl = http://officecdn.microsoft.com/pr/7ffbc6bf-bc32-4f92-8982-f9dd17fd3114

# Semi-Annual Enterprise Channel (Preview)
# CDNBaseUrl = http://officecdn.microsoft.com/pr/b8f9b850-328d-4355-9145-c59439a0c4cf

# Beta Channel
# CDNBaseUrl = http://officecdn.microsoft.com/pr/5440fd1f-7ecb-4221-8110-145efaa6372f


$baseUrl = "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60"
$regPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\"
$regKey = "CDNBaseUrl"
$updatesPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\"
$officeUpdatePath = "HKLM:\\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\"
$regKey2 = "UpdateChannel"

if (Test-Path $regPath)
{
    $CDNBaseUrl = Get-ItemProperty $regPath -Name $regKey -ErrorAction SilentlyContinue

    if (! $CDNBaseUrl)
    {
        New-ItemProperty -Name $regKey -Path $regPath -PropertyType string -Value $baseUrl -Force
    }
    else 
    {
        Set-ItemProperty -Name $regKey -Path $regPath -Value $baseUrl -Force
    }

    $UpdateChannel = Get-ItemProperty $regPath -Name $regKey2 -ErrorAction SilentlyContinue

    if (! $UpdateChannel)
    {
        New-ItemProperty -Name $regKey2 -Path $regPath -PropertyType string -Value $baseUrl -Force
    }
    else 
    {
        Set-ItemProperty -Name $regKey2 -Path $regPath -Value $baseUrl -Force
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
