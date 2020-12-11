Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox

$DefaultUser = 'idaniels'

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
}