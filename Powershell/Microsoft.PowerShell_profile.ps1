$DefaultUser = 'idaniels'

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module posh-git
    Import-Module oh-my-posh
    Set-PoshPrompt -Theme Paradox

    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
}