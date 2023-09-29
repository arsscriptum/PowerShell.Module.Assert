
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>



function Get-AssertionMessage ($Expected, $Actual, $Option, [hashtable]$Data = @{}, $CustomMessage, $DefaultMessage, [switch]$Pretty) 
{
    if (-not $CustomMessage)
    {
        $CustomMessage = $DefaultMessage
    }
    
    $expectedFormatted = Format-Nicely -Value $Expected -Pretty:$Pretty
    $actualFormatted = Format-Nicely -Value $Actual -Pretty:$Pretty

    $optionMessage = $null;
    if ($null -ne $Option)
    {
        $optionMessage = "Used options: $($Option -join ", ")."
    }


    $CustomMessage = $CustomMessage.Replace('<expected>', $expectedFormatted)
    $CustomMessage = $CustomMessage.Replace('<actual>', $actualFormatted)
    $CustomMessage = $CustomMessage.Replace('<expectedType>', (Get-ShortType -Value $Expected))
    $CustomMessage = $CustomMessage.Replace('<actualType>', (Get-ShortType -Value $Actual))
    $CustomMessage = $CustomMessage.Replace('<options>', $optionMessage)

    foreach ($pair in $Data.GetEnumerator())
    {
        $CustomMessage = $CustomMessage.Replace("<$($pair.Key)>", (Format-Nicely -Value $pair.Value))
    }

    $CustomMessage
}
