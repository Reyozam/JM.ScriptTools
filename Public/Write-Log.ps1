function Write-Log
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, ParameterSetName = "StartLog", ValueFromPipeline = $true)][switch]$StartLog,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = "StartLog")][string]$LogFile,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Message", ValueFromPipeline = $true)][string]$Message,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $false)][ValidateSet('Info', 'Warning', 'Error')][string]$Level = "Info",
        [Parameter(Mandatory = $false, ParameterSetName = "EndLog", ValueFromPipeline = $true)][switch]$EndLog,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $true)][int]$Tab,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $true)][int]$TimeStamp
        
    )

    #--------------------------------------------=
    # EXECUTION
    #--------------------------------------------=

    Switch ($PsCmdlet.ParameterSetName)
    {
        "StartLog"
        {
            $script:StartDate = Get-Date
            $User = [Security.Principal.WindowsIdentity]::GetCurrent()
            $Elevated = ([Security.Principal.WindowsPrincipal]$User).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

            if ($PSVersionTable.PSVersion -gt "4.0") { $CIM = Get-CimInstance win32_operatingsystem -Property Caption, Version, OSArchitecture }
            else { $CIM = Get-WmiObject win32_operatingsystem -Property Caption, Version, OSArchitecture }

            $Header = "------------------------------------------------------------------------------------------`r`n"
            $Header += "Script Name        : $($myinvocation.ScriptName)  `r`n"
            $Header += "Generated on       : $($StartDate.tostring("dd/MM/yy HH:mm:ss")) `r`n"
            $Header += "User               : $($user.Name) `r`n"
            $Header += "Elevated           : $Elevated`r`n"
            $Header += "Computer           : $ENV:COMPUTERNAME`r`n"
            $Header += "OS                 : $($CIM.Caption) [Build :$($CIM.Version)] `r`n"
            $Header += "PS Version         : $($PSVersionTable.PSVersion)`r`n"
            $Header += "LogFile            : $LogFile`r`n"
            $Header += "------------------------------------------------------------------------------------------`n"

                if (-not(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                $script:LogFile = $LogFile

                Write-Output $Header | Set-Content $script:Logfile -PassThru -Encoding unicode
        }

        "Message"
        {

            $BCKColor = $Host.ui.RawUI.ForegroundColor

            $Line = [System.Text.StringBuilder]::new()

            if ($TimeStamp){[void]$Line.Append("[$([datetime]::Now.ToString("HH:mm:ss:fff"))]")}
            #[void]$Line.Append([string]::Format(" [{0,-7}] ", $Level.ToUpper()))
            [void]$Line.Append("   " * $Tab)

            switch ($Level)
            {
                Info    { [void]$Line.Append("[i] ") ; $Host.ui.RawUI.ForegroundColor = "White"      }
                Error   { [void]$Line.Append("[x] ") ; $Host.ui.RawUI.ForegroundColor = "Red"        }
                Warning { [void]$Line.Append("[!] ") ; $Host.ui.RawUI.ForegroundColor = "DarkYellow" }
            }

            [void]$Line.Append($Message)

            Write-Output $Line.ToString() | Add-Content $script:Logfile -PassThru -Encoding unicode
            $host.ui.RawUI.ForegroundColor = $BCKColor

        
        }

        "EndLog"
        {
            $EndDate = Get-Date
            $TimeSpan = New-TimeSpan -Start $StartDate -End $EndDate

            $Footer += "`r`n"
            $Footer += "+----------------------------------------------------------------------------------------+`r`n"
            $Footer += "End Time                 : $EndDate`r`n"
            $Footer += "Total Duration           : $($TimeSpan.ToString()) `r`n"
            $Footer += "+----------------------------------------------------------------------------------------+"

            Write-Output $Footer | Add-Content $script:Logfile -PassThru -Encoding unicode
        }

    }

}





