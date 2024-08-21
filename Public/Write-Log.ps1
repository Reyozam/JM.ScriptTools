function Write-Log
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string[]]$Message,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false)][ValidateSet('Info', 'Success', 'Warning', 'Error')][string]$Level = 'Info',
        [Parameter(Mandatory = $false, ValueFromPipeline = $false)][ConsoleColor[]]$Color = 'White',
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)][int]$Tab,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)][switch]$TimeStamp,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false)][ValidateSet('Before', 'After')][string]$Jumpline,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)][string]$LogFile
    )

    #--------------------------------------------=
    # EXECUTION
    #--------------------------------------------=

    switch ($Level)
    {
        'Info' { $DefaultColor = 'White' ; $Icon =  '  ' }
        'Warning' { $DefaultColor = 'Yellow' ; $Icon = '! ' }
        'Error' { $DefaultColor = 'Red' ; $Icon = 'x ' }
        'Success' { $DefaultColor = 'Green' ; $Icon = '+ ' }
    }

    $Color = $Color -replace 'white', $DefaultColor

    if ($Jumpline -eq 'Before') { Write-Host -Object "`n" -NoNewline } #JUMPLINE
    if ($TimeStamp) { Write-Host "$([datetime]::Now.ToString('HH:mm:ss:fff '))" -ForegroundColor DarkGray -NoNewline } # TIMESTAMP
    if ($Tab -ne 0) { for ($i = 0; $i -lt $Tab; $i++) { Write-Host -Object '   ' -NoNewline } } #TABS
    Write-Host $icon -ForegroundColor $DefaultColor -NoNewline #ICONS


    if ($Message.Count -ne 0)
    {
        if ($Color.Count -ge $Message.Count)
        {
            for ($i = 0; $i -lt $Message.Length; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $Color[$i] -NoNewline }
        }
        else
        {
            for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $Color[$i] -NoNewline }
            for ($i = $Color.Length; $i -lt $Message.Length; $i++) { Write-Host -Object $Message[$i] -ForegroundColor $DefaultColor -NoNewline }
        }
    }
    Write-Host
    if ($Jumpline -eq 'After') { Write-Host -Object "`n" -NoNewline } #JUMPLINE

    if ($PSBoundParameters.ContainsKey('LogFile'))
    {
        if (-not(Test-Path $LogFile)) { [void](New-Item $LogFile -Force) }

        $StringElements = @(
            "$([datetime]::Now.ToString('HH:mm:ss:fff'))",
            "$([string]::Format('{0,-7}', $Level.ToUpper()))",

            "$($Message -join '')"
        )

        if ($Jumpline -eq 'Before') { Write-Output "" | Out-File -FilePath $LogFile -Append -Encoding unicode -Force }

        Write-Output $('{0} |{1}| {2} {3}' -f $([datetime]::Now.ToString('HH:mm:ss:fff')), $([string]::Format('{0,-7}', $Level.ToUpper())), $('   ' * $Tab), $($Message -join '') ) |
            Out-File -FilePath $LogFile -Append -Encoding unicode -Force

        if ($Jumpline -eq 'After') { Write-Output "" | Out-File -FilePath $LogFile -Append -Encoding unicode -Force }
    }

}