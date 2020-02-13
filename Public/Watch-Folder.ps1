function Watch-Folder
{

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Path = $pwd
    )
   
    $FileSystemWatcher = New-Object System.IO.FileSystemWatcher
    $FileSystemWatcher.Path = $Path
    $FileSystemWatcher.IncludeSubdirectories = $true

    $FileSystemWatcher.EnableRaisingEvents = $true

    $Action = {
        $details = $event.SourceEventArgs
        $Name = $details.Name
        $FullPath = $details.FullPath
        $OldFullPath = $details.OldFullPath
        $OldName = $details.OldName
        $ChangeType = $details.ChangeType
        $Timestamp = $event.TimeGenerated

        switch ($ChangeType)
        {
            'Changed' { Write-Host "[@] " -ForegroundColor Blue -NoNewline ; Write-Host "[MODIFIED] " -ForegroundColor Blue -NoNewline ; Write-Host "$FullPath" -ForegroundColor White }
            'Created' { Write-Host "[+] " -ForegroundColor Green -NoNewline ; ; Write-Host "[CREATED] " -ForegroundColor Green -NoNewline ; Write-Host "$FullPath" -ForegroundColor White }
            'Deleted' { Write-Host "[x] " -ForegroundColor Red -NoNewline; Write-Host "[DELETED] " -ForegroundColor Red -NoNewline ; Write-Host "$FullPath" -ForegroundColor White }
            'Renamed' { Write-Host "[~] " -ForegroundColor DarkYellow -NoNewline ; Write-Host "[RENAMED] " -ForegroundColor DarkYellow -NoNewline; Write-Host "$FullPath" -ForegroundColor White -NoNewline }
            default { Write-Host $_ -ForegroundColor Red -BackgroundColor White }
        }
    }

    $handlers = . {
        Register-ObjectEvent -InputObject $FileSystemWatcher -EventName Changed -Action $Action -SourceIdentifier FSChange
        Register-ObjectEvent -InputObject $FileSystemWatcher -EventName Created -Action $Action -SourceIdentifier FSCreate
        Register-ObjectEvent -InputObject $FileSystemWatcher -EventName Deleted -Action $Action -SourceIdentifier FSDelete
        Register-ObjectEvent -InputObject $FileSystemWatcher -EventName Renamed -Action $Action -SourceIdentifier FSRename
    }

    Write-Host "Watching for changes to $Path"

    try
    {
        do
        {
            Wait-Event -Timeout 1
        
        } while ($true)
    }
    finally
    {

        Unregister-Event -SourceIdentifier FSChange
        Unregister-Event -SourceIdentifier FSCreate
        Unregister-Event -SourceIdentifier FSDelete
        Unregister-Event -SourceIdentifier FSRename

        $Handlers | Remove-Job

        $FileSystemWatcher.EnableRaisingEvents = $false
        $FileSystemWatcher.Dispose()
        "Event Handler disabled."
    }
}