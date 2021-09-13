# Watches for all file changes in a given folder.

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.IncludeSubdirectories = $true
$watcher.Path = 'C:\DataPath\'
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true

$logFile = "C:\media\cutover\Log\filewatcher.log"

# back up the old log file
if (Test-Path $logFile) {
    $f = Get-Item $logFile
    $newName = "{0}-{1}{2}" -f $f.BaseName, $(Get-Date -Format FileDateTime), $f.Extension
    Move-Item $logFile $(Join-Path $f.DirectoryName $newName)
}

"Logging started at: $(get-date)" | out-file $logFile -Force

$action = {
   $path = $event.SourceEventArgs.FullPath
   $changetype = $event.sourceeventargs.changetype
   $message = "$path was $changetype at $(get-date)"
   $message | Out-File $logFile -Append 
   Write-Host $message
}

# Reset the events
Get-EventSubscriber | Unregister-Event

Register-ObjectEvent $watcher 'Created' -Action $action
Register-ObjectEvent $watcher 'Deleted' -Action $action
#Register-ObjectEvent $watcher 'Changed' -Action $action
Register-ObjectEvent $watcher 'Renamed' -Action $action

# To monitor the log file use:
# Get-Content "filewatcher.log" -Wait


# The events are registered in the powershell session. Closing the windows will remove them
# Or you can run the following commands:
# Get-EventSubscriber
# Get-EventSubscriber | Unregister-Event