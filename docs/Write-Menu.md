---
external help file: JM.ScriptTools-help.xml
Module Name: JM.ScriptTools
online version:
schema: 2.0.0
---

# Write-Menu

## SYNOPSIS
Create Menu with selection by arrows keys

## SYNTAX

```
Write-Menu [-Entries] <Object> [[-Title] <String>] [-Sort] [-MultiSelect] [<CommonParameters>]
```

## DESCRIPTION
Create Menu with selection by arrows keys and return selection.

## EXAMPLES

### EXEMPLE 1
```
$TopProcess = Get-Process | Sort-Object CPU | Select-Object -First 10
```

$Select = Write-Menu -Entries $TopProcess.Name -Title "Selectionnez le processus a arreter:"

Selectionnez le processus a arreter:
────────────────────────────────
    \> svchost
    svchost
    svchost
    svchost
    Registry
    OfficeClickToRun
    NvTelemetryContainer
    OriginWebHelperService
    svchost
    PnkBstrA

Stop-Process $Select

### EXEMPLE 2
```
Write-Menu -menuItems @(Get-ChildItem -File) -Title "Selectionnez les fichiers a supprimer" -Multiselect
```

Selectionnez les fichiers a supprimer
─────────────────────────────────────
    \[ \] CheckDNSPRODAD.ps1
    \[ \] DISM Demo.ps1
    \[ \] Log-20190405-1603.log
    \[x\] Log-20190405-1608.log
    \[x\] Log-20190407-1231.log
    \[x\] PROD_PostBascule.log
  \> \[x\] PROD_PreBascule.log
    \[ \] Report.html

## PARAMETERS

### -Entries
Array or hashtable containing the menu entries

```yaml
Type: Object
Parameter Sets: (All)
Aliases: InputObject

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Title
Title shown at the top of the menu.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Sort
Sort entries before they are displayed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultiSelect
Make possible to choose multiple items.
Return as an array

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
