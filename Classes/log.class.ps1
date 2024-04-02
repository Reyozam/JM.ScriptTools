Class Log
{
    [string]$FilePath
    [PSObject[]]$InfoMessages

    Log(){}

    #constructor
    Log($FilePath)
    {
        $this.FilePath = $FilePath
        Add-Content -Path $this.FilePath -Value "Start Log on $(Get-Date -Format "g")"
    }

    Info($MessageData)
    {

        $this.InfoMessages += Write-Information -MessageData $MessageData -Tags "Info" 6>&1 | Select-Object *
        "INFO: $MessageData" | Out-File -FilePath $this.FilePath -Append
        Write-Host $MessageData -ForegroundColor Blue
    }

    Warning($MessageData)
    {

        $this.InfoMessages += Write-Information -MessageData $MessageData -Tags "Warning" 6>&1 | Select-Object *
        "WARNING: $MessageData" | Out-File -FilePath $this.FilePath -Append
        Write-Host $MessageData -ForegroundColor DarkYellow
    }

    Error($MessageData)
    {

        $this.InfoMessages += Write-Information -MessageData $MessageData -Tags "Error" 6>&1 | Select-Object *
        "WARNING: $MessageData" | Out-File -FilePath $this.FilePath -Append
        Write-Host $MessageData -ForegroundColor Red
    }

    [psobject]ShowMessages()
    {
        return $this.InfoMessages | Select-Object TimeGenerated,Tags,MessageData
    }

    [string]ExportToJson()
    {
        return $this.InfoMessages | Select-Object TimeGenerated,Tags,MessageData | ConvertTo-Json
    }
}