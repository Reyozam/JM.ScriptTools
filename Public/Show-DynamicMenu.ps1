###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Show-DynamicMenu.ps1
# Autor        :  Julien Mazoyer
# Description  :  Create a CLI Menu
###############################################################################################################

<#    
        .SYNOPSIS
            Create a CLI Menu
        
        .DESCRIPTION
            Create a CLI Menu
    
        .EXAMPLE
            PS C:\> $Menu = @{
                MenuTitle = "Menu"
                MenuKeys = @(1,2,3,4)
                menuOptions = @("Options1","Options2","Options3","Options4")
                menuActions = @('Write-Host "You Choose Option1 !"','Write-Host "You Choose Option2 !"','Write-Host "You Choose Option3 !"','Write-Host "You Choose Option4 !"')
            }

            Show-DynamicMenu @Menu

            ================================================================ 
                                            MENU
            ================================================================
            [1] Options1
            [2] Options2
            [3] Options3
            [4] Options4
            Make a selection [1,2,3,4 OR Q to quit]
#>
function Show-DynamicMenu{
    Param(
        [Parameter(Mandatory=$true)]
        [string]$menuTitle,
        [Parameter(Mandatory=$false)]
        [array]$menuKeys,
        [Parameter(Mandatory=$true)]
        [array]$menuOptions,
        [Parameter(Mandatory=$true)]
        [array]$menuActions,
        [Parameter(Mandatory=$false)]
        [ConsoleColor[]]$Color = "Green"
    )
    # validates that the number of objects in keys, options, and actions match
    if (-Not ($menuOptions.Length -eq $menuActions.Length)) {
        Write-Error "menuKeys, and menuActions must have the same number of objects in each array."
        return
    }
    else { 
        if ($MemuKeys.Length -eq 0) {$MenuKeys = @(1..($menuOptions.Length))}
        $menuLength = $menuKeys.Length 
    }

    

    $ShowMenu = $true
    while ($ShowMenu -eq $true){
        
        #TITLE
        $Longer = ($menuOptions | Sort-Object Length -Descending | Select-Object -First 1).Length
        Write-Host $menuTitle.ToUpper()  -ForegroundColor $Color
        Write-Host ("=" * ($Longer+ 8)) -ForegroundColor $Color
        Write-Host ""


        for ($i=1;$i -le $menuLength; $i++){
            Write-Host " [$($menuKeys[$i-1])]" -NoNewline -ForegroundColor $Color
            Write-Host " $($menuOptions[$i-1])"
            #" " + $menuKeys[$i-1] + ": " + $menuOptions[$i-1]
        }
        Write-Host ""
        Write-Host "Make a selection" -NoNewline
        Write-Host " [$($MenuKeys -join ",") OR Q to quit] " -ForegroundColor DarkYellow -NoNewline   
        $selection = Read-Host
        $switch = 'switch($selection){'
        for($i=1;$i -le $menuLength; $i++){
            $switch += "`n`t $($menuKeys[$i-1]) { $($menuActions[$i-1]); break }"
        }
        $switch += "`n`t Q {`$ShowMenu = `$false}"
        $switch += "`n`t default { Write-Warning 'Invalid selection.';pause }"
        $switch += "`n}"
        Invoke-Expression $switch
    }
}
<#
$Menu = @{
    MenuTitle = "Menu"
    menuOptions = @("Options1","Options2","Options3","Options4")
    menuActions = @('Write-Host "You Choose Option1 !"','Write-Host "You Choose Option2 !"','Write-Host "You Choose Option3 !"','Write-Host "You Choose Option4 !"')
    Color = "Yellow"
}

Show-DynamicMenu @Menu
#>
