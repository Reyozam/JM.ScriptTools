function Select-ObjectColor
{
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(ValueFromPipeline = $true)]
        [Object[]]$InputObject,

        [Parameter(Mandatory = $true)]
        [string[]]$SelectedProperty,

        [Parameter(Mandatory = $true)]
        [string]$ColoredProperty,

        [Parameter()]
        [string]$SuccessMatch,

        [Parameter()]
        [string]$WarningMatch,

        [Parameter()]
        [string]$ErrorMatch

    )

    process
    {

        $IndexOf = $SelectedProperty.IndexOf($ColoredProperty)
        $ArrayBefore = $SelectedProperty[0..($IndexOf - 1)]
        $ArrayAfter = $SelectedProperty[$($IndexOf + 1)..$($SelectedProperty.Count)]
    
    
        $ColoredColumn = @{
            Name       = $ColoredProperty
            Expression =
            {
                switch ($_.$ColoredProperty)
                {
                    "$SuccessMatch" { $color = "32"; break }
                    "$WarningMatch" { $color = '33'; break }
                    "$ErrorMatch"   { $color = "31"; break }
                    default { $color = "0" }
                }
                $e = [char]27
                "$e[${color}m$($_.$ColoredProperty)${e}[0m"
            }
            
        }
       
        $hash = @{ Property = $ArrayBefore + $ColoredColumn + $ArrayAfter }
        $InputObject | Select-Object @hash
    }
}