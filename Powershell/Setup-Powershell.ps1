# Set up PowerShell for Git and powerline

# run this for powershell as pwsh

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

install-module Az

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

Install-Module -name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck


Install-Module -Name PSScriptAnalyzer