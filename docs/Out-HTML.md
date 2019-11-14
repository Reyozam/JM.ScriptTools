---
external help file: JM.ScriptTools-help.xml
Module Name: JM.ScriptTools
online version:
schema: 2.0.0
---

# Out-HTML

## SYNOPSIS
Create a HTML Table with object send by the pipeline

## SYNTAX

```
Out-HTML [[-Path] <String>] [[-Title] <String>] [[-ErrorMatch] <String>] [[-WarningMatch] <String>]
 [[-SuccessMatch] <String>] [[-Template] <String>] [-Open] [-Search]
```

## DESCRIPTION
Create a HTML Table with object send by the pipeline. 
2 CSS Theme with colored line by string match

## EXAMPLES

### EXEMPLE 1
```
Get-Service | Select Name,Status | Out-HTML -ErrorMatch "Stopped" -SuccessMatch "Running" -Title "Services" -Template Dark -Open -Search
```

## PARAMETERS

### -Path
{{ Fill Path Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "$Home\Desktop\report$(Get-Date -format yyyy-MM-dd-HH-mm-ss).html"
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
{{ Fill Title Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: PowerShell Output
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorMatch
Color Line in red where this string is present .
Add counter of error on top of the table

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WarningMatch
{{ Fill WarningMatch Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SuccessMatch
Color Line in green where this string is present .
Add counter of success on top of the table

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
{{ Fill Template Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Light
Accept pipeline input: False
Accept wildcard characters: False
```

### -Open
{{ Fill Open Description }}

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

### -Search
Add a search field for dynamic search in the file

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
