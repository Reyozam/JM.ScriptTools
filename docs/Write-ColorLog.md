---
external help file: JM.ScriptTools-help.xml
Module Name: JM.ScriptTools
online version:
schema: 2.0.0
---

# Write-ColorLog

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Text
```
Write-ColorLog [-Text] <String[]> [[-Color] <ConsoleColor[]>] [[-StartTab] <Int32>] [[-LinesBefore] <Int32>]
 [[-LinesAfter] <Int32>] [-ShowTime] [-NoNewLine] [[-LogFile] <String>] [<CommonParameters>]
```

### StartLog
```
Write-ColorLog [-StartLog] [[-Color] <ConsoleColor[]>] [[-StartTab] <Int32>] [[-LinesBefore] <Int32>]
 [[-LinesAfter] <Int32>] [-ShowTime] [-NoNewLine] [[-LogFile] <String>] [<CommonParameters>]
```

### EndLog
```
Write-ColorLog [-EndLog] [[-Color] <ConsoleColor[]>] [[-StartTab] <Int32>] [[-LinesBefore] <Int32>]
 [[-LinesAfter] <Int32>] [-ShowTime] [-NoNewLine] [[-LogFile] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Color
{{ Fill Color Description }}

```yaml
Type: ConsoleColor[]
Parameter Sets: (All)
Aliases:
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndLog
{{ Fill EndLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: EndLog
Aliases:

Required: True
Position: Nommé
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LinesAfter
{{ Fill LinesAfter Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesBefore
{{ Fill LinesBefore Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
{{ Fill LogFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoNewLine
{{ Fill NoNewLine Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowTime
{{ Fill ShowTime Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartLog
{{ Fill StartLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: StartLog
Aliases:

Required: True
Position: Nommé
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -StartTab
{{ Fill StartTab Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Nommé
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
{{ Fill Text Description }}

```yaml
Type: String[]
Parameter Sets: Text
Aliases:

Required: True
Position: Nommé
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

### System.Management.Automation.SwitchParameter

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
