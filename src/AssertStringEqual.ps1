
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>



function Test-StringEqual 
{
    param (
        [String]$Expected, 
        $Actual, 
        [switch]$CaseSensitive,
        [switch]$IgnoreWhitespace
    )

    if ($IgnoreWhitespace)
    { 
        $Expected = $Expected -replace '\s'
        $Actual = $Actual -replace '\s'
    }

    if (-not $CaseSensitive) 
    {
        $Expected -eq $Actual
    } 
    else 
    {
        $Expected -ceq $Actual
    }
}

function Get-StringEqualDefaultFailureMessage ([String]$Expected, $Actual) 
{
    "Expected the string to be '$Expected' but got '$Actual'."
}

function Assert-StringEqual 
{
    param (
        [Parameter(Position=1, ValueFromPipeline=$true)]
        $Actual, 
        [Parameter(Position=0)]
        [String]$Expected,
        [String]$CustomMessage,
        [switch]$CaseSensitive,
        [switch]$IgnoreWhitespace
    )
    
    $_actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input

    if (-not $CustomMessage)
    {
        $formattedMessage = Get-StringEqualDefaultFailureMessage -Expected $Expected -Actual $_actual
    }
    else 
    {
        $formattedMessage = Get-CustomFailureMessage -Expected $Expected -Actual $_actual -CustomMessage $CustomMessage
    }

    $stringsAreEqual = Test-StringEqual -Expected $Expected -Actual $_actual -CaseSensitive:$CaseSensitive -IgnoreWhitespace:$IgnoreWhiteSpace
    if (-not ($stringsAreEqual)) 
    {
        throw [Assertions.AssertionException]$formattedMessage
    }
}
