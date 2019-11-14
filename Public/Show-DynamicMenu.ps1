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
        [Parameter(Mandatory=$true)]
        [array]$menuKeys,
        [Parameter(Mandatory=$true)]
        [array]$menuOptions,
        [Parameter(Mandatory=$true)]
        [array]$menuActions
    )
    # validates that the number of objects in keys, options, and actions match
    if (-Not (($menuKeys.Length -eq $menuOptions.Length) -and ($menuOptions.Length -eq $menuActions.Length))) {
        Write-Error "menuKeys, menuOptions, and menuActions must have the same number of objects in each array."
        return
    }
    else { $menuLength = $menuKeys.Length }
    $ShowMenu = $true
    while ($ShowMenu -eq $true){
        
        #TITLE
        Write-Host ("=" * $Host.Ui.RawUI.BufferSize.Width) -ForegroundColor Green
        Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $menuTitle.ToUpper())  -ForegroundColor Green
        Write-Host ("=" * $Host.Ui.RawUI.BufferSize.Width) -ForegroundColor Green
        Write-Host ""


        for ($i=1;$i -le $menuLength; $i++){
            Write-Host " [$($menuKeys[$i-1])]" -NoNewline -ForegroundColor Green
            Write-Host " $($menuOptions[$i-1])"
            #" " + $menuKeys[$i-1] + ": " + $menuOptions[$i-1]
        }
        Write-Host "Make a selection" -NoNewline
        Write-Host " [$($Menu.MenuKeys -join ",") OR Q to quit] " -ForegroundColor DarkYellow -NoNewline   
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
    MenuKeys = @(1,2,3,4)
    menuOptions = @("Options1","Options2","Options3","Options4")
    menuActions = @('Write-Host "You Choose Option1 !"','Write-Host "You Choose Option2 !"','Write-Host "You Choose Option3 !"','Write-Host "You Choose Option4 !"')
}

Show-DynamicMenu @Menu
#>
