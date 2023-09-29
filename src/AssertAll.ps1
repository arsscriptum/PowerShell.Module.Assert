
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>



function Assert-All {
    param (
        [Parameter(ValueFromPipeline=$true, Position=1)]
        $Actual, 
        [Parameter(Position=0, Mandatory=$true)]
        [scriptblock]$FilterScript,
        [String]$CustomMessage
    )
    

    $Expected = $FilterScript
    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    # we are jumping between modules so I need to explicitly pass the _ variable
    # simply using '&' won't work
    # see: https://blogs.msdn.microsoft.com/sergey_babkins_blog/2014/10/30/calling-the-script-blocks-in-powershell/
    $actualFiltered = $Actual | foreach { 
        $underscore = Get-Variable _
        $pass = $FilterScript.InvokeWithContext($null, $underscore, $null)
    
        if (-not $pass) { $_ }
    }

    if ($actualFiltered)
    { 
        $data = @{ 
            actualFiltered = $actualFiltered
            actualFilteredCount = @($actualFiltered).Count
        }
        $Message = Get-AssertionMessage -Expected $Expected -Actual $Actual -Data $data -CustomMessage $CustomMessage -DefaultMessage "Expected all items in collection '<actual>' to pass filter '<expected>', but <actualFilteredCount> of them '<actualFiltered>' did not pass the filter."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}
