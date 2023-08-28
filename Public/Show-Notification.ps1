function Show-Notification
{
    [cmdletbinding()]
    Param (
        [string]$Title = 'Powershell',
        [Parameter(mandatory = $true)][string]$Message,
        [ValidateSet('None', 'Info', 'Warning', 'Error')] [string]$BalloonIcon = 'Info'
    )

    Add-Type -AssemblyName System.Windows.Forms
    $Notification = New-Object System.Windows.Forms.NotifyIcon
    $Notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process -Id $PID).Path)
    $Notification.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::$BalloonIcon
    $Notification.BalloonTipText = $Message
    $Notification.BalloonTipTitle = $Title
    $Notification.Visible = $true
    $Notification.ShowBalloonTip(10000)

}