$DefaultUser = 'idaniels'
$env:POSH_SESSION_DEFAULT_USER = $DefaultUser

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module posh-git
    $env:POSH_GIT_ENABLED = $true
    #Import-Module oh-my-posh
    #Set-PoshPrompt -Theme Paradox
    #Set-PoshPrompt -Theme  ~/.oh-my-posh.omp.json
    oh-my-posh prompt init pwsh --config ~/.oh-my-posh.omp.json | Invoke-Expression

    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineKeyHandler -Chord Ctrl+Alt+f -Function GotoBrace
}