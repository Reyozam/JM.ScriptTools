---
external help file: JM.ScriptTools-help.xml
Module Name: JM.ScriptTools
online version:
schema: 2.0.0
---

# Write-LineProgress

## SYNOPSIS
Write Progress Bar in console

## SYNTAX

```
Write-LineProgress [-Activity] <String> [-Progress] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Write Progress Bar in console

## EXAMPLES

### EXEMPLE 1
```
for ($i = 0; $i -lt 100; $i++) {

Start-Sleep 1
        Write-LineProgress -Activity "Test" -Progress $i
        }

Test 
[■■■■■■■■■■■----------------------------------------------------------------] 15%
```
## PARAMETERS

### -Activity
{{ Fill Activity Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Progress
{{ Fill Progress Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
