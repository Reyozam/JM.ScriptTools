
Function Get-RunInfo
{

  [CmdletBinding()]
  Param(
    [switch]$AsString
  )

  $cimos = Get-CimInstance win32_operatingsystem -Property Caption, Version, OSArchitecture
  $os = "$($cimos.Caption) [$($cimos.OSArchitecture)]"
  $osver = $cimos.Version
  

  $current = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal]$current
  $Elevated = $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
  $user = $current.Name
  $computer = $env:COMPUTERNAME
      
  
  $info = [pscustomObject]@{ 
    User            = $user
    Elevated        = $elevated
    Computername    = $computer
    OperatingSystem = $os
    BuildNumber     = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ReleaseId).ReleaseId
    BuildVersion    = $osver
    PSVersion       = $PSVersionTable.PSVersion.ToString()
    Edition         = $PSVersionTable.PSEdition
    PSHost          = $host.Name
    WSMan           = $PSVersionTable.WSManStackVersion.ToString()
    ExecutionPolicy = (Get-ExecutionPolicy)
    Culture         = $host.CurrentCulture
  }
  
  if ($AsString)
  {
    $info | Out-String
  }
  else
  {
    $info
  }
}