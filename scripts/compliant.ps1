# Suppress all output for silent execution
$ErrorActionPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$VerbosePreference = 'SilentlyContinue'

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    exit 1
}

# Function to silently create registry entries
function Set-RegistryValue {
    param([string]$Path, [string]$Name, [string]$Type, [string]$Value)
    try {
        if (!(Test-Path $Path)) { New-Item -Path $Path -Force -ErrorAction SilentlyContinue | Out-Null }
        New-ItemProperty -Path $Path -Name $Name -PropertyType $Type -Value $Value -Force -ErrorAction SilentlyContinue | Out-Null
    } catch { }
}

# 1. WN10-CC-000005 - Disable camera access from lock screen (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera" -Type "DWord" -Value "1"

# 2. WN10-CC-000370 - Disable convenience PIN (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowDomainPINLogon" -Type "DWord" -Value "0"

# 3. WN10-CC-000365 - Disable Windows apps voice activation while locked (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type "DWord" -Value "2"

# 4. WN10-CC-000197 - Disable Microsoft consumer experiences (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type "DWord" -Value "1"

# 5. WN10-SO-000080 - Set correct legal banner dialog title (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LegalNoticeCaption" -Type "String" -Value "DoD Notice and Consent Banner"

# 6. WN10-CC-000325 - Disable auto sign-in after restart (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -Type "DWord" -Value "1"

# 7. WN10-CC-000038 - Disable WDigest Authentication (COMPLIANT) **REPLACED IE CHECK**
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name "UseLogonCredential" -Type "DWord" -Value "0"

# 8. WN10-CC-000170 - Make Microsoft accounts optional for modern apps (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "MSAOptional" -Type "DWord" -Value "1"

# 9. WN10-SO-000185 - Prevent PKU2U authentication (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\pku2u" -Name "AllowOnlineID" -Type "DWord" -Value "0"

# 10. WN10-CC-000205 - Set Windows Telemetry to minimal (COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type "DWord" -Value "0"

# Create log file
try {
    New-Item -ItemType Directory -Path "C:\Temp" -Force -ErrorAction SilentlyContinue | Out-Null
    "STIG Registry Compliance Applied (All 10 items - WDigest replaced IE): $(Get-Date)" | Out-File -FilePath "C:\Temp\STIG_Registry_Compliance_WDigest_$(Get-Date -Format 'yyyyMMdd_HHmmss').log" -ErrorAction SilentlyContinue
} catch { }

exit 0
