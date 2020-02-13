Function Invoke-InputBox
{

    [cmdletbinding()]

    Param(
        [ValidateNotNullorEmpty()]
        [ValidateScript( { $_.length -le 25 })]
        [string]$Title = "Input",

        [ValidateNotNullorEmpty()]
        [ValidateScript( { $_.length -le 50 })]
        [string]$Message = "Please enter a value:",

        [switch]$AsSecureString
    )

    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName PresentationCore

    Remove-Variable -Name InputValue -Scope script -ErrorAction SilentlyContinue

    $Form = New-Object System.Windows.Window
    $Stack = New-Object System.Windows.Controls.StackPanel

    
    $Form.Title = $title
    $Form.Height = 150
    $Form.Width = 350

    $Label = New-Object System.Windows.Controls.Label
    $Label.Content = "    $Message"
    $Label.HorizontalAlignment = "left"
    $Stack.AddChild($Label)

    if ($AsSecureString)
    {
        $inputbox = New-Object System.Windows.Controls.PasswordBox
    }
    else
    {
        $inputbox = New-Object System.Windows.Controls.TextBox
    }

    $inputbox.Width = 300
    $inputbox.HorizontalAlignment = "center"

    $Stack.AddChild($inputbox)

    $space = New-Object System.Windows.Controls.Label
    $space.Height = 10
    $Stack.AddChild($space)

    $btn = New-Object System.Windows.Controls.Button
    $btn.Content = "_OK"

    $btn.Width = 65
    $btn.HorizontalAlignment = "center"
    $btn.VerticalAlignment = "bottom"

    $btn.Add_click( {
            if ($AsSecureString)
            {
                $script:InputValue = $inputbox.SecurePassword
            }
            else
            {
                $script:InputValue = $inputbox.text
            }
            $Form.Close()
        })

    $Stack.AddChild($btn)
    $space2 = New-Object System.Windows.Controls.Label
    $space2.Height = 10
    $Stack.AddChild($space2)

    $btn2 = New-Object System.Windows.Controls.Button
    $btn2.Content = "_Cancel"

    $btn2.Width = 65
    $btn2.HorizontalAlignment = "center"
    $btn2.VerticalAlignment = "bottom"

    $btn2.Add_click( {
            $Form.Close()
        })

    $Stack.AddChild($btn2)

    #add the Stack to the Form
    $Form.AddChild($Stack)

    #show the Form
    [void]$inputbox.Focus()
    $Form.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen

    [void]$Form.ShowDialog()

    $script:InputValue


}