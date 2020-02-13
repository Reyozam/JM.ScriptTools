Function Out-TableColor
{

    [cmdletbinding()]

    Param(
        [Parameter(Position = 0, Mandatory)]
        [hashtable]$PropertyConditions,

        [Parameter(Mandatory)]
        [string]$Property,

        [Parameter(Mandatory, ValueFromPipeline)]
        [PSObject[]]$InputObject
    )

    Begin
    {
        if ($PropertyConditions.Values | Where-Object { $([enum]::GetNames([system.consolecolor])) -notcontains $_ })
        {
            throw "Invalid Color"
        }
        $BckForegroung = $Host.UI.RawUI.ForegroundColor
    }

    Process
    {
        $Value = $Inputobject.$Property.ToString()
        if ($PropertyConditions.containsKey($Value))
        {
            $host.ui.RawUI.ForegroundColor = $PropertyConditions.item($Value)
        }
        else
        {
            #use orginal color
            Write-Debug "No matches found"
            $host.ui.RawUI.ForegroundColor = $BckForegroung
        }        
        $PSItem
    } 

    End
    {
        $host.ui.RawUI.ForegroundColor = $BckForegroung
    } 

}
