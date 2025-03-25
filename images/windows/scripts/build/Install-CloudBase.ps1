################################################################################
##  File:  Install-CloudBase.ps1
##  Desc:  Install CloudBase-Init for cloud environment initialization
################################################################################

Write-Host "Installing CloudBase-Init..."

# Download and Install CloudBase-Init
Write-Host "Downloading CloudBase-Init installer..."
$cloudBaseUrl = "https://cloudbase.it/downloads/CloudbaseInitSetup_x64.msi"

Install-Binary -Type MSI -Url $cloudBaseUrl -InstallArgs @("/qb-", "/norestart")

# Verify installation
Write-Host "Verifying CloudBase-Init installation..."
$cloudbaseService = Get-Service -Name "cloudbase-init" -ErrorAction SilentlyContinue
if (-not $cloudbaseService) {
    Write-Error "CloudBase-Init service not found. Installation might have failed."
    exit 1
}

Write-Host "CloudBase-Init has been successfully installed"

# Uncomment if Pester tests are available for CloudBase-Init
# Invoke-PesterTests -TestFile "CloudTools" -TestName "CloudBase-Init"
