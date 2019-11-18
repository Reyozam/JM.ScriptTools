---
external help file: JM.ScriptTools-help.xml
Module Name: JM.ScriptTools
online version:
schema: 2.0.0
---

# Write-LogColor

## SYNOPSIS
Function de Log avancée

## SYNTAX

### Text
```
Write-LogColor -Text <String[]> [-Color <ConsoleColor[]>] [-StartTab <Int32>] [-LinesBefore <Int32>]
 [-LinesAfter <Int32>] [-ShowTime] [-NoNewLine] [-LogFile <String>] [<CommonParameters>]
```

### StartLog
```
Write-LogColor [-StartLog] [-Color <ConsoleColor[]>] [-StartTab <Int32>] [-LinesBefore <Int32>]
 [-LinesAfter <Int32>] [-ShowTime] [-NoNewLine] [-LogFile <String>] [<CommonParameters>]
```

### EndLog
```
Write-LogColor [-EndLog] [-Color <ConsoleColor[]>] [-StartTab <Int32>] [-LinesBefore <Int32>]
 [-LinesAfter <Int32>] [-ShowTime] [-NoNewLine] [-LogFile <String>] [<CommonParameters>]
```

## DESCRIPTION
Function pour logger dans la console et dans un fichier

## EXAMPLES

### EXEMPLE 1
```
# Démarrer le script


Write-LogColor -StartLog -LogFile $LogFile
```
```
#Uniquement affiché dans la console
Write-LogColor -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow
```
```
#Dans la console et vers le log
Write-LogColor -Text "Red ", "Green ", "Yellow " -Color Red,Green,Yellow -LogFile $LogFile
```
```
#Finir le script
Write-LogColor -Endlog -LogFile $LogFile
```

### EXEMPLE 2
```
#Definir le paramétre LogFile par defaut :


$LogFile = 'C:\logs\mylogfile.log'
$PSDefaultParameterValues = @{ 'Write-LogColor:LogFile'   = $LogFile}
```
## PARAMETERS

### -Text
{{ Fill Text Description }}

```yaml
Type: String[]
Parameter Sets: Text
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -StartLog
{{ Fill StartLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: StartLog
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -EndLog
{{ Fill EndLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: EndLog
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Color
{{ Fill Color Description }}

```yaml
Type: ConsoleColor[]
Parameter Sets: (All)
Aliases:
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: Named
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTab
{{ Fill StartTab Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesAfter
{{ Fill LinesAfter Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoNewLine
{{ Fill NoNewLine Description }}

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

### -LogFile
{{ Fill LogFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
