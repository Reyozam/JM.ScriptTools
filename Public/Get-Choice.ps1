function Get-Choice(
    [string]
    $Caption = 'Confirm',
    [string]
    $Message = 'Are you sure you want to continue?',
    [string[]]
    $Choices = ('&Yes', 'Continue', '&No', 'Skip this'),
    [int]
    $DefaultChoice = 0
)
{
    $descriptions = @()
    for ($i = 0; $i -lt $Choices.Count; $i += 2)
    {
        $c = [System.Management.Automation.Host.ChoiceDescription]$Choices[$i]
        $c.HelpMessage = $Choices[$i + 1]
        $descriptions += $c
    }
    $Host.UI.PromptForChoice($Caption, $Message, [System.Management.Automation.Host.ChoiceDescription[]]$descriptions, $DefaultChoice)
}