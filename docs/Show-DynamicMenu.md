---
external help file: JM.ScriptTools-help.xml
Module Name: Jm.scriptTools
online version:
schema: 2.0.0
---

# Show-DynamicMenu

## SYNOPSIS
Create a CLI Menu

## SYNTAX

```
Show-DynamicMenu [-menuTitle] <String> [-menuKeys] <Array> [-menuOptions] <Array> [-menuActions] <Array>
 [<CommonParameters>]
```

## DESCRIPTION
Create a CLI Menu

## EXAMPLES

### EXEMPLE 1
```
$Menu = @{


MenuTitle = "Menu"
    MenuKeys = @(1,2,3,4)
    menuOptions = @("Options1","Options2","Options3","Options4")
    menuActions = @('Write-Host "You Choose Option1 !"','Write-Host "You Choose Option2 !"','Write-Host "You Choose Option3 !"','Write-Host "You Choose Option4 !"')
}

Show-DynamicMenu @Menu

================================================================ 
                                MENU
================================================================
[1] Options1
[2] Options2
[3] Options3
[4] Options4
Make a selection [1,2,3,4 OR Q to quit]
```
## PARAMETERS

### -menuTitle
{{ Fill menuTitle Description }}

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

### -menuKeys
{{ Fill menuKeys Description }}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuOptions
{{ Fill menuOptions Description }}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuActions
{{ Fill menuActions Description }}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
