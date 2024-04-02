function ConvertFrom-Error
{
<#
.SYNOPSIS
    Return Error information in a object
.DESCRIPTION
    Return Error information in a object
.PARAMETER ErrorRecord
    Error Record
.EXAMPLE
    ConvertFrom-Error $error[0]

    Exception : Tentative de division par zéro.
    Reason    : RuntimeException
    Target    : 
    Script    : Test-Error
    Line      : 1
    Column    : 1
#>
    [CmdletBinding()]
    param
    (
        [Management.Automation.ErrorRecord]
        [Parameter(Mandatory, ValueFromPipeline)]
        $ErrorRecord
    )
  
    process
    {
        [PSCustomObject]@{
            Exception = $ErrorRecord.Exception.Message
            Reason    = $ErrorRecord.CategoryInfo.Reason
            Target    = $ErrorRecord.CategoryInfo.TargetName
            Script    = $ErrorRecord.InvocationInfo.ScriptName
            Line      = $ErrorRecord.InvocationInfo.ScriptLineNumber
            Column    = $ErrorRecord.InvocationInfo.OffsetInLine
        }
    }
}