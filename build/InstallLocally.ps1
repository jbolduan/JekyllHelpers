# Check if running as admin
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity)

if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $ModuleInstallPath = "$($env:ProgramFiles)\PowerShell\Modules\JekyllHelpers"
}
else {
    $ModulePath = $env:PSModulePath -split ';' | Where-Object { $_.ToUpper().contains("USERS") -and $_.ToUpper().Contains("DOCUMENTS") } | Select-Object -First 1
    $ModuleInstallPath = "$ModulePath\JekyllHelpers"
}

if (Test-Path -Path $ModuleInstallPath) {
    Remove-Item -Path $ModuleInstallPath -Force -Recurse
}

New-Item -Path $ModuleInstallPath -Force -ItemType Directory
Copy-Item -Path "$($PSScriptRoot)\..\JekyllHelpers\*" -Recurse -Destination $ModuleInstallPath

$ModuleManifest = Get-Content -Path "$ModuleInstallPath\JekyllHelpers.psd1"
$ModuleManifest.Replace('{version}', '1.0.0').Replace('{prerelease}', '') | Set-Content -Path "$ModuleInstallPath\JekyllHelpers.psd1"
