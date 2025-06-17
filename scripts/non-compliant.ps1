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

# Function to silently remove registry entries
function Remove-RegistryValue {
    param([string]$Path, [string]$Name)
    try {
        if (Test-Path $Path) {
            Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction SilentlyContinue | Out-Null
        }
    } catch { }
}

# 1. WN10-CC-000005 - Enable camera access from lock screen (NON-COMPLIANT)
Remove-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera"

# 2. WN10-CC-000370 - Enable convenience PIN (NON-COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowDomainPINLogon" -Type "DWord" -Value "1"

# 3. WN10-CC-000365 - Allow Windows apps voice activation while locked (NON-COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type "DWord" -Value "0"

# 4. WN10-CC-000197 - Enable Microsoft consumer experiences (NON-COMPLIANT)
Remove-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures"

# 5. WN10-SO-000080 - Set INCORRECT legal banner dialog title (NON-COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LegalNoticeCaption" -Type "String" -Value "Incorrect Banner Title"

# 6. WN10-CC-000325 - Enable auto sign-in after restart (NON-COMPLIANT)
Remove-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn"

# 7. WN10-CC-000038 - Enable WDigest Authentication (NON-COMPLIANT) **REPLACED IE CHECK**
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name "UseLogonCredential" -Type "DWord" -Value "1"

# 8. WN10-CC-000170 - Make Microsoft accounts required for modern apps (NON-COMPLIANT)
Remove-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "MSAOptional"

# 9. WN10-SO-000185 - Allow PKU2U authentication (NON-COMPLIANT)
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\pku2u" -Name "AllowOnlineID" -Type "DWord" -Value "1"

# 10. WN10-CC-000205 - Set Windows Telemetry to Full (NON-COMPLIANT)
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type "DWord" -Value "3"

# Create log file
try {
    New-Item -ItemType Directory -Path "C:\Temp" -Force -ErrorAction SilentlyContinue | Out-Null
    "STIG Registry Violations Created (10 items - Replaced IE with WDigest): $(Get-Date)" | Out-File -FilePath "C:\Temp\STIG_Registry_Violations_WDigest_$(Get-Date -Format 'yyyyMMdd_HHmmss').log" -ErrorAction SilentlyContinue
} catch { }

exit 0
