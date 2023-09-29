
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>




<#
#̷𝓍    𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍    Platform Invoke (P/Invoke) for 🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 
#̷𝓍    🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>



function Get-AssertModuleInformation{

        $ModuleName = $ExecutionContext.SessionState.Module
        $ModuleScriptPath = $ScriptMyInvocation = $Script:MyInvocation.MyCommand.Path
        $ModuleScriptPath = (Get-Item "$ModuleScriptPath").DirectoryName
        $CurrentScriptName = $Script:MyInvocation.MyCommand.Name
        $ModuleInformation = @{
            Module        = $ModuleName
            ModuleScriptPath  = $ModuleScriptPath
            CurrentScriptName = $CurrentScriptName
        }
        return $ModuleInformation
}

function Get-AssertModuleExportsPath{   
    $ModPath = (Get-AssertModuleInformation).ModuleScriptPath
    $ExportsPath = Join-Path $ModPath 'exports'
    return $ExportsPath
}

function Register-AssertionException{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $false)]
        [Switch]$Force
    )
    $ExportsPath = Get-AssertModuleExportsPath
    $CsSource = (Join-Path $ExportsPath "AssertionException.cs")  
    
    $typeDefinition = Get-Content "$CsSource" | Out-String
    Add-Type -TypeDefinition $typeDefinition -WarningAction SilentlyContinue
}



