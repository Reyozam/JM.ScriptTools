if ($myinvocation.line -match "-verbose") {
    $VerbosePreference = "continue"
}

# Dot source public/private functions
$Public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public/*.ps1')  -Recurse -ErrorAction Stop)
$Private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private/*.ps1') -Recurse -ErrorAction Stop)

foreach ($import in @($Public + $Private)) {
    try {
        Write-Verbose "Importing $($import.FullName)"
        . $import.FullName
    }
    catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $Public.BaseName

