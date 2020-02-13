$script:CSS = @"
<style>
body {
    font-family: 'Consolas';
    color: #343434;
    background-color: #FFF;
    font-size: 12px;
    font-smooth: auto;
}


h1 {
    font-size: 20px;
    text-transform: uppercase;
}

H2{
    font-size: 18px;
    text-transform: uppercase;
}

H3{
    display:inline-block;
    background-color: #343434;
    color: #F2F2F2;
    font-size: 16px;
    width:auto;
    padding:0.5em;
    
}

table {
    width: 100%;
    table-layout: auto;
    white-space: nowrap;
    border-collapse: collapse;
    background: #F5F5F5;
}

table .absorbing-column {
    width: 100%;
}

td {
    width: 1px;
    border-bottom: 2px solid #fff;
    border-right: 2px solid #fff;
    padding: 7px;
}

th {
    border-right: 2px solid #fff;
    padding: 7px;
    text-align: left;
    text-transform: uppercase;
    background-color: #343434;
    color: #F2F2F2;
    font-weight: bold;
}

.footer {
    padding-top: 10px;
    font-size: 12px;
    font-weight: bold;
}

.red {
    background-color: crimson;
    color: white;
    font-weight: bold; 
}

.green {
    background-color: yellowgreen;
    color: white;
    font-weight: bold;  
}
.orange {
    background-color: darkorange;
    color: white;
    font-weight: bold;  
}
</style>
"@

function Out-HTMLReport
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $True)][string[]]$HTMLFragments,
        [string]$Title,
        [string]$PreContent
    )

    #====================================================
    $CallingScript = @(Get-PSCallStack)[1].InvocationInfo.MyCommand.Source
    
    $StyleSheet = $CSS | Out-String

    if ($PSBoundParameters.ContainsKey('Title'))
    {
        $TitleTag = "<title>$title</title>"
    }
    else
    {
        $TitleTag = ""
    }

    $Body = $HTMLFragments | Out-String

    Write-Verbose "Adding Pre and Post content"
    if ($PSBoundParameters.ContainsKey('precontent'))
    {
        $Body = "<H1>$PreContent</H1><hr>`n$Body"
    }
    

    #Footer 
    $PostContent = '<div class = "footer">' 
    $PostContent += "<div> Generated on : $([datetime]::Now -f 'd')</div>"
    $PostContent += "<div> Computer     : $($env:COMPUTERNAME)</div>"
    $PostContent += "<div> Script       : $($CallingScript)</div>"
    $PostContent += '</div>' 

    $Body = "$Body`n$PostContent"
    
    ConvertTo-HTML -Head "$Stylesheet`n$Titletag" -Body $Body  
}

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


<#
$Service_Conditions = @{
    name       = "Status"
    expression = { $_.Status }
    css        = { if ($_.Status -eq "Stopped") { 'red' } else { 'green' } }
}

$Process_Conditions = @{
    name       = "Cpu"
    expression = { $_.cpu }
    css        = { if ($_.cpu -gt 7000) { 'red' } elseif ($_.cpu -gt 5000) { 'orange' } else {"green"} }
}

$FragmentsService = Get-Service | Select-object -first 10  | Out-HTMLReportFragment -PreContent "Service" -Properties name,$Service_Conditions
$FragmentProcess = Get-Process | Sort-Object cpu -Descending | Select-Object -first 10 | Out-HTMLReportFragment -PreContent "Process" -Properties name,$Process_Conditions
$HTMLCode = Out-HTMLReport -HTMLFragments $FragmentsService,$FragmentProcess -Title "Report" -PreContent "Services & Process"
$HTMLCode | Out-File $env:USERPROFILE\Desktop\TestHTML.html
#>
