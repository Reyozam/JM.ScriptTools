###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Write-LogColor.ps1
# Autor        :  Julien Mazoyer
# Description  :  Custom Log Function
###############################################################################################################

<#
    .SYNOPSIS
    Function de Log avancée

    .DESCRIPTION
    Function pour logger dans la console et dans un fichier

    .EXAMPLE
    # Démarrer le script
    Write-LogColor -StartLog -LogFile $LogFile

    #Uniquement affiché dans la console
    Write-LogColor -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow

    #Dans la console et vers le log
    Write-LogColor -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow -LogFile $LogFile

    #Finir le script
    Write-LogColor -Endlog -LogFile $LogFile

    .EXAMPLE
    #Definir le paramétre LogFile par defaut :
    $LogFile = 'C:\logs\mylogfile.log'
    $PSDefaultParameterValues = @{ 'Write-LogColor:LogFile'   = $LogFile}

#>

function Write-LogColor 
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Text", ValueFromPipeline = $true)][string[]]$Text, 
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $false)][ValidateSet('Info', 'Success', 'Warning', 'Error')][string]$Level,
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $false)][System.ConsoleColor[]]$Color,           
        [Parameter(Mandatory = $false, ParameterSetName = "StartLog", ValueFromPipeline = $true)][switch]$StartLog,
        [Parameter(Mandatory = $false, ParameterSetName = "EndLog", ValueFromPipeline = $true)][switch]$EndLog,
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $true)][int]$Tab,
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $true)][switch]$ShowTime,
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $true)][switch]$NoNewLine,
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $true)][int]$LinesBefore,  
        [Parameter(Mandatory = $false, ParameterSetName = "Text", ValueFromPipeline = $true)][int]$LinesAfter,     
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)][string]$LogFile 
    )
 
    #=============================================
    # EXECUTION
    #=============================================
    
    $LevelSymbol = @{
        Info    = [PSCustomObject]@{Symbol = "[i]" ; "Color" = "Blue"      ; "LogTag" = "INFO" }
        Success = [PSCustomObject]@{Symbol = "[+]" ; "Color" = "Green"     ; "LogTag" = "SUCCESS" }
        Warning = [PSCustomObject]@{Symbol = "[!]" ; "Color" = "DarkYellow"; "LogTag" = "WARNING" }
        Error   = [PSCustomObject]@{Symbol = "[x]" ; "Color" = "Red"       ; "LogTag" = "ERROR" }
    }
 
    Switch ($PsCmdlet.ParameterSetName)
    {
        "StartLog" # HEADER
        {
            $CurrentScriptName = $myinvocation.ScriptName
            $script:StartDate = Get-Date
            $LogStartDate_str = Get-Date -f "HH:mm:ss"
 
            #Information Systéme & Contexte
            $Current = [Security.Principal.WindowsIdentity]::GetCurrent()
            $CurrentUser = $Current.Name
            $CurrentComputer = $ENV:COMPUTERNAME
        
            if ($PSVersionTable.PSVersion -gt "4.0") { $CIM = Get-CimInstance win32_operatingsystem -Property Caption, Version, OSArchitecture }
            else { $CIM = Get-WmiObject win32_operatingsystem -Property Caption, Version, OSArchitecture }
            $OS = "$($CIM.Caption) [$($CIM.OSArchitecture)]"
            $OSVersion = $CIM.Version
            $PSVersion = ($PSVersionTable.PSVersion)
            $Principal = [Security.Principal.WindowsPrincipal]$Current
            $Elevated = $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
 
            $Header = "+========================================================================================+`r`n"
            $Header += "Script Name                     : $CurrentScriptName`r`n"
            $Header += "When generated                  : $LogStartDate_str`r`n"
            $Header += "User                            : $CurrentUser`r`n"
            $Header += "Elevated                        : $Elevated`r`n"
            $Header += "Computer                        : $CurrentComputer`r`n"
            $Header += "OS                              : $OS`r`n"
            $Header += "OS Version                      : $OSVersion`r`n"
            $Header += "PS Version                      : $PSVersion`r`n"
            $Header += "+========================================================================================+`n"
 
            
            # Log file creation
            if (!(Test-Path $LogFile)) {[void](New-Item $LogFile -Force)}
            Write-Output $Header | Out-File -FilePath $LogFile -Append -Encoding unicode -Force
            Write-Host $Header -ForegroundColor $LevelSymbol.Info.Color
            break
        }
 
        "Text" #LOG
        {
            if ($Text.Count -eq 0) { return }
            if ($LinesBefore -ne 0) { for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } }        #Add empty line before
            if ($ShowTime) { Write-Host "[$([datetime]::Now.ToString("HH:mm:ss"))] " -NoNewline }                     #Add Time before output
            if ($StartTab -ne 0) { for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } }
            if ($Level -ne "") {Write-Host "$($LevelSymbol.$Level.Symbol) " -ForegroundColor $LevelSymbol.$Level.Color -NoNewline}

            if ($Color.Count -eq 0)
            {
                Write-Host $([System.String]::Concat($Text)) -NoNewline
            }
            else
            {
                if ($Color.Count -ge $Text.Count) 
                {
                    for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
                }
                else
                {
                    for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
                    for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -NoNewLine }
                }
            }
            

            if ($NoNewLine -eq $true) { Write-Host -NoNewline } else { Write-Host }                 #Support for no new line
            if ($LinesAfter -ne 0) { for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } }  #Add empty line after

            if ($LogFile -ne "")
            {
                if (!(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                # Save to file

                $LogLine = "[$([datetime]::Now.ToString("HH:mm:ss"))] "
                if ($Level -ne "") {$LogLine += "[$($LevelSymbol.$Level.LogTag)] "}

                $LogLine += $([System.String]::Concat($Text))
                
                try
                {
                    Write-Output "$LogLine" | Out-File $LogFile -Encoding unicode -Append -Force
                }
                catch
                {
                    $_.Exception
                }
            }

            break
        }
 
        "EndLog" 
        {
            $EndDate = Get-Date
            $TimeSpan = New-TimeSpan -Start $StartDate -End $EndDate
            $Duration_Str = "{0} hours {1} min. {2} sec" -f $TimeSpan.Hours, $TimeSpan.Minutes, $TimeSpan.Seconds
             
            $Footer += "`r`n"
            $Footer += "+========================================================================================+`r`n"
            $Footer += "End Time                 : $EndDate`r`n"
            $Footer += "Total Duration           : $Duration_Str`r`n"
            $Footer += "+========================================================================================+"
 
            if ($LogFile -ne "") 
            {
                if (!(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }
                Write-Output $Footer | Out-File -FilePath $LogFile -Append -Encoding unicode -Force
            }

            Write-Host $Footer -ForegroundColor White
        }
 
    }
}