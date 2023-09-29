
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>



function Test-NotLike
{
    param (
        [String]$Expected, 
        $Actual, 
        [switch]$CaseSensitive
    )

    if (-not $CaseSensitive) 
    {
        $Actual -NotLike $Expected
    } 
    else 
    {
        $actual -cNotLike $Expected
    }
}

function Get-NotLikeDefaultFailureMessage ([String]$Expected, $Actual, [switch]$CaseSensitive) 
{
    $caseSensitiveMessage = ""
    if ($CaseSensitive)
    {
        $caseSensitiveMessage = " case sensitively"
    }
    "Expected the string '$Actual' to$caseSensitiveMessage not match '$Expected' but it matched it."
}

function Assert-NotLike
{
    param (
        [Parameter(Position=1, ValueFromPipeline=$true)]
        $Actual, 
        [Parameter(Position=0, Mandatory=$true)]
        [String]$Expected,
        [Switch]$CaseSensitive,
        [String]$CustomMessage
    )
    
    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input

    if ($Actual -isnot [string])
    {
        throw [ArgumentException]"Actual is expected to be string, to avoid confusing behavior that -like operator exhibits with collections. To assert on collections use Assert-Any, Assert-All or some other collection assertion."
    }

    $stringsAreANotLike = Test-NotLike -Expected $Expected -Actual $Actual -CaseSensitive:$CaseSensitive -IgnoreWhitespace:$IgnoreWhiteSpace
    if (-not ($stringsAreANotLike)) 
    {
        if (-not $CustomMessage)
        {
            $formattedMessage = Get-NotLikeDefaultFailureMessage -Expected $Expected -Actual $Actual -CaseSensitive:$CaseSensitive
        }
        else 
        {
            $formattedMessage = Get-CustomFailureMessage -Expected $Expected -Actual $Actual -CustomMessage $CustomMessage -CaseSensitive:$CaseSensitive
        }

        throw [Assertions.AssertionException]$formattedMessage
    }
}
