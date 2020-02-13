function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Message", ValueFromPipeline = $true)][string]$Message, 
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $false)][ValidateSet('Info', 'Success', 'Warning', 'Error')][string]$Level = "Info",         
        [Parameter(Mandatory = $false, ParameterSetName = "StartLog", ValueFromPipeline = $true)][switch]$StartLog,
        [Parameter(Mandatory = $false, ParameterSetName = "EndLog", ValueFromPipeline = $true)][switch]$EndLog,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $true)][int]$Tab,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $true)][switch]$HideTime,
        [Parameter(Mandatory = $false, ParameterSetName = "Message", ValueFromPipeline = $true)][switch]$NoNewLine,   
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)][string]$LogFile 
    )
 
    #--------------------------------------------=
    # EXECUTION
    #--------------------------------------------=
    
    $Icons = @{
        Info    = "[i] " 
        Success = "[+] " 
        Warning = "[!] " 
        Error   = "[x] "
    }

    $Colors = @{
        Info    = "Blue"
        Success = "Green"
        Warning = "DarkYellow"
        Error   = "Red"
    }
 
    Switch ($PsCmdlet.ParameterSetName)
    {
        "StartLog"
        {
            $script:StartDate = Get-Date
            $User = [Security.Principal.WindowsIdentity]::GetCurrent()
            $Elevated = ([Security.Principal.WindowsPrincipal]$User).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

            if ($PSVersionTable.PSVersion -gt "4.0") { $CIM = Get-CimInstance win32_operatingsystem -Property Caption, Version, OSArchitecture }
            else { $CIM = Get-WmiObject win32_operatingsystem -Property Caption, Version, OSArchitecture }
            
            $Header = "+----------------------------------------------------------------------------------------+`r`n"
            $Header += "Script Name        : $($myinvocation.ScriptName)  `r`n"
            $Header += "Generated on       : $($StartDate.tostring("dd/MM/yy HH:mm:ss")) `r`n"
            $Header += "User               : $($user.Name) `r`n"
            $Header += "Elevated           : $Elevated`r`n"
            $Header += "Computer           : $ENV:COMPUTERNAME`r`n"
            $Header += "OS                 : $($CIM.Caption) [Build :$($CIM.Version)] `r`n"
            $Header += "PS Version         : $($PSVersionTable.PSVersion)`r`n"
            $Header += "+----------------------------------------------------------------------------------------+`n"
 
            # Log file creation
            if ($PSBoundParameters.ContainsKey("LogFile")) 
            {
                if (!(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                Write-Output $Header | Out-File -FilePath $LogFile -Encoding unicode -Force
            }
            
            Write-Host $Header -ForegroundColor $Colors["Info"]
            break
        }
 
        "Message"
        {
            $Time = "[$([datetime]::Now.ToString("HH:mm:ss:fff"))] "

            if (!$HideTime) { Write-Host $Time -ForegroundColor $Colors[$Level] -NoNewline }
            if ($Tab -ne 0) { for ($i = 0; $i -lt $Tab; $i++) { Write-Host "    " -NoNewLine } }

            Write-Host $Icons[$Level] -ForegroundColor $Colors[$Level] -NoNewline

            if ($Level -eq "Info")
            {
                Write-Host $Message
            }
            else
            {
                Write-Host $Message -ForegroundColor $Colors[$Level]
            } 

            #Append Line in LogFile
            if ($PSBoundParameters.ContainsKey("LogFile"))
            {
                if (-not(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                Write-Output ("{0}[{1}] {2}" -f $Time, [string]::Format("{0,-7}", $Level.ToUpper()), $Message ) | Out-File -FilePath $LogFile -Append -Encoding unicode -Force
            }
            
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
 
            if ($PSBoundParameters.ContainsKey("LogFile"))
            {
                if (!(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                Write-Output $Footer | Out-File -FilePath $LogFile -Append -Encoding unicode -Force
            }
            Write-Host $Footer -ForegroundColor $Colors["Info"]
        }
 
    }
}



