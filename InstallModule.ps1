
[CmdletBinding()]
param (
    [Parameter()][string]$RepoURI
)


$ZipURL = if ($RepoURI.EndsWith('/')) {
    return "$RepoURI"+"archive/master.zip"
}
else {
    return "$RepoURI"+"/archive/master.zip"
}

$ModuleName = ($RepoURI -split "/")[-1]
#=====================================================================================
$DownloadFile = Join-Path $env:TEMP $($ModuleName + ".zip")
$TempDir = Join-Path $env:TEMP -ChildPath (New-Guid).Guid
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")


if ($IsAdmin)
{
    $Destination = switch -Wildcard ($PSVersionTable.PSVersion.Major)
    {
        { $_ -gt 5 } { "C:\Program Files\PowerShell\Modules\$ModuleName" }
        default { "C:\Program Files\WindowsPowerShell\Modules\$ModuleName" }
    }
}
else
{
    $Destination = switch -Wildcard ($PSVersionTable.PSVersion.Major)
    {
        { $_ -gt 5 } { Join-Path $([environment]::getfolderpath("mydocuments")) -ChildPath "Powerhell\Modules\$ModulesName"}
        default { Join-Path $([environment]::getfolderpath("mydocuments")) -ChildPath "WindowsPowerhell\Modules\$ModulesName"}
    }
}

if ($Destination) {Remove-Item $Destination -Force -Recurse}

Write-Verbose "Download of $ZipURL ..." -Verbose
Invoke-WebRequest -Uri $ZipURL -OutFile $DownloadFile
Unblock-File $DownloadFile

Write-Verbose "Unzip $DownloadFile" -Verbose
Expand-Archive -Path $DownloadFile -DestinationPath $TempDir -Force
$UnzippedFolder = (Get-ChildItem $TempDir | Where-Object { $_.Name -like "*-master" }).FullName 


Write-Verbose "Copy to $Destination ..."

Get-ChildItem $UnzippedFolder | Copy-Item -Destination $Destination -Recurse -Container -Force




