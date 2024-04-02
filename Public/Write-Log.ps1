Function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string]$Message,
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true)][string]$Context,
        [Parameter(Mandatory = $false)][ValidateSet('Info', 'Warning', 'Error', 'Success', 'Debug')][string]$Level = 'Info',
        [Parameter(Mandatory = $false)][ValidateSet('Before', 'After')][string]$JumpLine,
        [Parameter(Mandatory = $false)][switch]$TimeStamp,
        [Parameter(Mandatory = $false)][switch]$Tab,
        [Parameter(Mandatory = $false)][string]$LogFile,
        [Parameter(Mandatory = $false)][switch]$ClearLog
    )

    $ESC = [char]27
    $String = [System.Text.StringBuilder]::new()

    if ($JumpLine -eq 'Before' ) { [void]$String.Append("`n") }

    switch ($PSBoundParameters)
    {
        { $_['TimeStamp'] } { [void]$String.Append("$ESC[90m$(Get-Date -f '[HH:mm:ss] ')$ESC[0m") }
        { $_['Context'] } { [void]$String.Append("$ESC[36m$("$($Context.ToUpper()) ")$ESC[0m") }
        { $_['Tab'] } { [void]$String.Append("  ") }
    }

    switch ($Level)
    {
        Info
        {
            [void]$String.Append("$ESC[37m  $($Message)$ESC[0m ")
        }
        Error
        {
            [void]$String.Append("$ESC[91mx $($Message)$ESC[0m ")
        }
        Warning
        {
            [void]$String.Append("$ESC[93m! $($Message)$ESC[0m ")
        }
        Success
        {
            [void]$String.Append("$ESC[92m+ $($Message)$ESC[0m ")
        }
        Debug
        {
            [void]$String.Append("$ESC[35m? $($Message)$ESC[0m ")
        }
    }

    if ($JumpLine -eq 'After' ) { [void]$String.Append("`n") }

    $String.ToString()

    #LOG
    if ( $LogFile -and $Level -ne "Debug" )
    {
        if (!(Test-Path $LogFile)) { New-Item -Path $LogFile -ItemType File -Force | Out-Null }

        $OutFileParams = @{ FilePath = $LogFile  ; Encoding = 'utf8' }
        if (-not $ClearLog) { $OutFileParams['Append'] = $true }

        if ($JumpLine -eq 'Before' ) { ' ' | Out-File @OutFileParams }
        if ($Tab) {$Indent = "  "}
        if ($Context) {$ContextString = " [{0}]" -f $Context }
        '{0,-21}{1,-7} {2} {3}{4}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Level.ToUpper() , $ContextString , $Indent, $Message | Out-File @OutFileParams
        if ($JumpLine -eq 'After' ) { ' '  | Out-File @OutFileParams }
    }

}

