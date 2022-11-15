Function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string]$Message,
        [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true)][string]$Context,
        [Parameter(Mandatory = $false)][ValidateSet('Info', 'Warning', 'Error', 'Success')][string]$Level = 'Info',
        [Parameter(Mandatory = $false)][ValidateSet('Before', 'After')][string]$JumpLine,
        [Parameter(Mandatory = $false)][switch]$TimeStamp,
        [Parameter(Mandatory = $false)][int]$Tab = 0,
        [Parameter(Mandatory = $false)][string]$LogFile,
        [Parameter(Mandatory = $false)][switch]$ClearLog
    )

    $ESC = [char]27
    $String = [System.Text.StringBuilder]::new()

    if ($TimeStamp) { [void]$String.Append("$ESC[90m$(Get-Date -f "[HH:mm:ss]")$ESC[0m ")  }

    switch ($Level)
    {
        Info {
            [void]$String.Append("$ESC[37m$("   ")$ESC[0m ")
            if ($Tab -gt 0) { [void]$String.Append("   ")  }
            if ($Context) { [void]$String.Append("$ESC[96m$("[$Context]")$ESC[0m ") }
            [void]$String.Append("$ESC[37m$($Message)$ESC[0m ")
        }
        Error {
            [void]$String.Append("$ESC[91m$("x ")$ESC[0m ")
            if ($Tab -gt 0) { [void]$String.Append("   ")  }
            if ($Context) { [void]$String.Append("$ESC[96m$("[$Context]")$ESC[0m ") }
            [void]$String.Append("$ESC[91m$($Message)$ESC[0m ")
        }
        Warning {
            [void]$String.Append("$ESC[93m$("! ")$ESC[0m ")
            if ($Tab -gt 0) { [void]$String.Append("   ")  }
            if ($Context) { [void]$String.Append("$ESC[96m$("[$Context]")$ESC[0m ") }
            [void]$String.Append("$ESC[93m$($Message)$ESC[0m ")
        }
        Success {
            [void]$String.Append("$ESC[92m$("+ ")$ESC[0m ")
            if ($Tab -gt 0) { [void]$String.Append("   ")  }
            if ($Context) { [void]$String.Append("$ESC[96m$("[$Context]")$ESC[0m ") }
            [void]$String.Append("$ESC[92m$($Message)$ESC[0m ")
        }
    }

    if ($JumpLine -eq 'Before' ) { Write-Output "" }
    $String.ToString()
    if ($JumpLine -eq 'After' ) { Write-Output "" }

    #LOG
    if ( $LogFile )
    {
        if (!(Test-Path $LogFile)) { New-Item -Path $LogFile -ItemType File -Force | Out-Null }

        $OutFileParams = @{ FilePath = $LogFile  ; Encoding = 'utf8' }
        if (-not $ClearLog) { $OutFileParams['Append'] = $true }

        if ($JumpLine -eq 'Before' ) { ' ' | Out-File @OutFileParams }
        '{0,-21}[{1,-10}] [{2}] {3}{4}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Level.ToUpper() , $Context  , $Indent, $Message | Out-File @OutFileParams
        if ($JumpLine -eq 'After' ) { ' '  | Out-File @OutFileParams }
    }

}