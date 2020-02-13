function Wait-Condition
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[scriptblock]$Condition,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[int]$Timeout,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[int]$RetryInterval = 1
	)

	try
	{
		[string]$ConditionASString = $Conditon
		Write-Verbose "Wait $Timeout seconds for the condition to be fulfilled" -Verbose
		$timer = [Diagnostics.Stopwatch]::StartNew()
		while (($timer.Elapsed.TotalSeconds -lt $Timeout) -and (!(& $Condition $ArgumentList)))
		{
			Start-Sleep -Seconds $RetryInterval
			$totalSecs = [math]::Round($timer.Elapsed.TotalSeconds, 0)
			Write-Verbose -Message "Condition not met after [$totalSecs] seconds..."
		}
		$timer.Stop()
		if ($timer.Elapsed.TotalSeconds -gt $Timeout)
		{
			Write-Warning 'Condition not met before timeout period.'
		}
		else
		{
			Write-Verbose -Message 'Condition met before timeout period.'
		}
	}
	catch
	{
		Write-Error -Message $_.Exception.Message
	}
}