Function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string]$Message,
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true)][string]$Context,
        [Parameter(Mandatory = $false)][ValidateSet('Info', 'Warning', 'Error', 'Success')][string]$Level = 'Info',
        [Parameter(Mandatory = $false)][ValidateSet('Before', 'After')][string]$JumpLine,
        [Parameter(Mandatory = $false)][switch]$TimeStamp,
        [Parameter(Mandatory = $false)][switch]$Tab,
        [Parameter(Mandatory = $false)][string]$LogFile,
        [Parameter(Mandatory = $false)][switch]$ClearLog
    )

    $ANSIColors = @{
        Success = "$([char]0x1b)[92m"
        Warning = "$([char]0x1b)[93m"
        Error   = "$([char]0x1b)[91m"
        Context = "$([char]0x1b)[96m"
        Time    = "$([char]0x1b)[90m"
        Reset   = "$([char]0x1b)[0m"
    }

    $Indent = '    '


    $ESC = [char]27
    #$Icon = [char]0x25A0
    $String = [System.Text.StringBuilder]::new()

    if ($TimeStamp) { [void]$String.Append("$($ANSIColors['Time'])$(Get-Date -f 'hh:mm:ss:ffff')$($ANSIColors['Reset']) ") }
    if ($Context) { [void]$String.Append("$($ANSIColors['Context'])$Context$($ANSIColors['Reset']) ") }
    if ($TAB) { [void]$String.Append($Indent) }


    switch ($Level)
    {
        Info { [void]$String.Append("$Message") }
        Warning { [void]$String.Append("$($ANSIColors['Warning'])$Message$($ANSIColors['Reset'])") }
        Error { [void]$String.Append("$($ANSIColors['Error'])$Message$($ANSIColors['Reset'])") }
        Success { [void]$String.Append("$($ANSIColors['Success'])$Message$($ANSIColors['Reset'])") }
    }

    if ($JumpLine -eq 'Before' ) { Write-Output '' }
    Write-Output $String.ToString()
    if ($JumpLine -eq 'After' ) { Write-Output '' }

    #LOG
    if ( $LogFile )
    {
        $OutFileParams = @{ FilePath = $LogFile  ; Encoding = 'utf8' ; Force = $true }
        if (-not $ClearLog) { $OutFileParams['Append'] = $true }

        if ($JumpLine -eq 'Before' ) { ' ' | Out-File @OutFileParams }
        '{0,-21}{1,-10} {2} {3}{4}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Level.ToUpper() , $Context  , $Indent, $Message | Out-File @OutFileParams
        if ($JumpLine -eq 'After' ) { ' '  | Out-File @OutFileParams }
    }

}
