Function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string]$Message,
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true)][string]$Context,
        [Parameter(Mandatory = $false)][ValidateSet('Info', 'Warning', 'Error', 'Success')][string]$Level = "Info",
        [Parameter(Mandatory = $false)][ValidateSet('Before', 'After')][string]$JumpLine,
        [Parameter(Mandatory = $false)][int]$Tab = 0,
        [Parameter(Mandatory = $false)][string]$LogFile,
        [Parameter(Mandatory = $false)][switch]$ClearLog
    )

    switch ($Level)
    {
        Info
        {
            $Label = @{Log = "[INFO]" ; Icon = "   " ; Color = "White" }
                    
        }
        Error
        {
            $Label = @{Log = "[ERROR]" ; Icon = "[x]" ; Color = "Red" }
        }
        Warning
        {
            $Label = @{Log = "[WARNING]" ; Icon = "[!]" ; Color = "DarkYellow" }
        }
        Success
        {
            $Label = @{Log = "[SUCCESS]" ; Icon = "[+]" ; Color = "Green" }
        }
    }
    
    $TabString = "  "
    if ($Tab -gt 0) { $Indent = "{0}|{1}" -f $($TabString * ($Tab - 1)), $TabString }
    else { $Indent = "" }

    if ($Context) { $Context = "[" + $Context + "]" }
            
    if ($JumpLine -eq "Before" ) { Write-Host }
    Write-Host  $( "{0,-4} {3,-7} {1}{2}" -f $Label["Icon"], $Indent, $Message, $Context ) -ForegroundColor $Label["Color"]
    if ($JumpLine -eq "After" ) { Write-Host }

    #LOG
    if ( $LogFile )
    {
        if (!(Test-Path $LogFile)) { New-Item -Path $LogFile -ItemType File -Force | Out-Null }

        $OutFileParams = @{ FilePath = $LogFile  ; Encoding = "utf8" }
        if (-not $ClearLog) { $OutFileParams["Append"] = $true }


        if ($JumpLine -eq "Before" ) { " " | Out-File @OutFileParams }
        "{0,-21}{1,-10} {4,-7} {2}{3}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Label["Log"], $Indent, $Message, $Context | Out-File @OutFileParams
        if ($JumpLine -eq "After" ) { " "  | Out-File @OutFileParams }
    }

} 