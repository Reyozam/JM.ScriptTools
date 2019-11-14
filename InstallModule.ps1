$ZipURL = "https://github.com/Reyozam/JM.ScriptTools/archive/master.zip"
$ModuleName = "JM.ScriptTools"
#=====================================================================================
$DownloadFile = Join-Path $env:TEMP $($ModuleName + ".zip")
$TempDir = Join-Path $env:TEMP -ChildPath (New-Guid).Guid

if ($PSVersionTable.PSVersion.Major -gt 5)
{
    $Destination = "C:\Program Files\PowerShell\Modules\$ModuleName"
}
else
{
    $Destination = "C:\Program Files\WindowsPowerShell\Modules\$ModuleName"
}

Write-Verbose "Download of $ZipURL ..." -Verbose
Invoke-WebRequest -Uri $ZipURL -OutFile $DownloadFile
Unblock-File $DownloadFile

Write-Verbose "Unzip $DownloadFile" -Verbose
Expand-Archive -Path $DownloadFile -DestinationPath $TempDir -Force
$UnzippedFolder = (Get-ChildItem $TempDir | Where-Object {$_.Name -like "*-master"}).FullName 


Write-Verbose "Copy to $Destination ..."

Get-ChildItem $UnzippedFolder | Copy-Item -Destination $Destination -Recurse -Container -Force




