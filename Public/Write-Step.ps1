function Write-Step
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true )][string]$Message,
        [Parameter(Mandatory = $true )][string]$Prefix,
        [Parameter(Mandatory = $false)][ValidateSet('Info', 'Success', 'Warning', 'Error')][string]$Type = "Info",
        [Parameter(Mandatory = $false)][int]$Tabs
        
    )
    
    switch ($Type) 
    {
        "info" { $Icon = "[i]" ; $Color = "Cyan" }
        "Success" { $Icon = "[+]" ; $Color = "Green" }
        "Warning" { $Icon = "[!]" ; $Color = "DarkYellow" }
        "Error" { $Icon = "[x]" ; $Color = "Red" }
    }

    Write-Host $("{0} [{1}] {2}" -f $Icon,$Prefix,$("  " * $Tabs)) -ForegroundColor $Color -NoNewline
    Write-Host $Message

}