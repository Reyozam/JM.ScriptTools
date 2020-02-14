function Out-HTMLReportFragment 
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [object[]]$InputObject,
        [string]$PreContent,
        [object[]]$Properties = '*',
        [string]$PostContent
    )
    
    begin
    {
        $LineCount = 0
        $Out = ""
        $wrote_first_line = $false

        if ($PSBoundParameters.ContainsKey("PreContent"))
        {
            $Out += "<H2>$Precontent</H2>" 
        }
        
        $Out += "<table>"

        if ($Properties -eq '*') 
        {
            $AllProperties = $true
        } 
        else 
        {
            $AllProperties = $false
        }

    }
    
    process
    {

        foreach ($Object in $InputObject) 
        {
            $LineCount ++
            $DataRow = ""
            $HeaderRow = ""

            if ($AllProperties) 
            {
                $Properties = $Object | Get-Member -MemberType Properties | Select-Object -ExpandProperty Name
            }

            foreach ($Prop in $Properties) 
            {
                Write-Verbose "Processing property"
                $Name = $null
                $Value = $null
                $CellCSS = $null

                if ($Prop -is [string]) 
                {
                    Write-Verbose "Property $Prop"
                    $Name = $Prop
                    $Value = $Object.($Prop)
                }
                elseif ($Prop -is [hashtable]) 
                {
                    Write-Verbose "Property hashtable"

                    #Column name
                    if ($prop.ContainsKey('name')) { $Name = $Prop['Name'] }
                    #Cell CSS Condition
                    if ($Prop.ContainsKey('css')) { $CellCSS = $Object | ForEach-Object $prop['css'] }
                    #Cell Value
                    if ($prop.ContainsKey('expression')) { $Value = $Object | ForEach-Object $prop['expression'] }
                }
                else
                {
                    Write-Verbose "Unhandled property $Prop" 
                }

                $HeaderRow += "<th>$Name</th>"

                if ($null -ne $CellCSS)
                {
                    $DataRow += "<td class=`"$CellCSS`">$Value</td>"
                }
                else
                {
                    $DataRow += "<td>$Value</td>"
                }


            }

            if (-not $Wrote_First_Line) 
            {
                Write-Verbose "Writing header row"
                $Out += "<tr>$HeaderRow</tr><tbody>"
                $Wrote_First_Line = $true
            }

            $Out += "<tr>$datarow</tr>"

        }
        
    }

    end
    {
        if ($LineCount -eq 0)
        {
            $Out += "<H3>No Item Found !</H3>" 
        }

        Write-Verbose "PostContent"
        if ($PSBoundParameters.ContainsKey('PostContent'))
        {
            $Out += "`n$PostContent"
        }
        Write-Verbose "Done"
        $Out += "</tbody></table></div>"
        Write-Output $out
    }
}