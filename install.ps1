# ==========================================
# My Custom Office Downloader
# ==========================================
Clear-Host
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "   My Custom Office Downloader" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Office Version Selection
Write-Host "Select Office Version:" -ForegroundColor Yellow
Write-Host "1. Office LTSC Professional Plus 2021"
Write-Host "2. Office Professional Plus 2019"
Write-Host "3. Microsoft 365 Apps for Enterprise"
$choice = Read-Host "Enter Choice (1/2/3)"

if ($choice -eq '1') { $Product = "ProPlus2021Volume" }
elseif ($choice -eq '2') { $Product = "ProPlus2019Volume" }
else { $Product = "O365ProPlusRetail" }

Write-Host ""
Write-Host "Select Applications to EXCLUDE (Type 'y' to exclude, 'n' to keep):" -ForegroundColor Yellow

$exWord = Read-Host "Exclude Word? (y/n)"
$exExcel = Read-Host "Exclude Excel? (y/n)"
$exPPT = Read-Host "Exclude PowerPoint? (y/n)"
$exAccess = Read-Host "Exclude Access? (y/n)"

# Generate XML
$xml = @"
<Configuration>
  <Add OfficeClientEdition="64" Channel="Current">
    <Product ID="$Product">
      <Language ID="en-us" />
"@

if ($exWord -eq 'y') { $xml += "`n      <ExcludeApp ID=`"Word`" />" }
if ($exExcel -eq 'y') { $xml += "`n      <ExcludeApp ID=`"Excel`" />" }
if ($exPPT -eq 'y') { $xml += "`n      <ExcludeApp ID=`"PowerPoint`" />" }
if ($exAccess -eq 'y') { $xml += "`n      <ExcludeApp ID=`"Access`" />" }

$xml += @"
    </Product>
  </Add>
</Configuration>
"@

# Create Temp Directory
$workDir = "C:\OfficeSetupTemp"
New-Item -Path $workDir -ItemType Directory -Force | Out-Null
Set-Location $workDir

# Save XML
$xml | Out-File -FilePath "$workDir\config.xml" -Encoding UTF8

# Download Official ODT
Write-Host "`nDownloading Official Office Deployment Tool..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://download.microsoft.com/download/2/7/A/27AF1EE6-FA03-4B33-A62E-0C132E2C877D/officedeploymenttool_17830-20162.exe" -OutFile "odt.exe"

# Extract Tool
Write-Host "Extracting Setup Files..." -ForegroundColor Cyan
Start-Process -FilePath ".\odt.exe" -ArgumentList "/extract:$workDir /quiet" -Wait

# Run Installation
Write-Host "Downloading and Installing Office (This may take a while)..." -ForegroundColor Green
Start-Process -FilePath ".\setup.exe" -ArgumentList "/configure config.xml" -Wait

# Cleanup
Set-Location "C:\"
Remove-Item -Path $workDir -Recurse -Force
Write-Host "`nInstallation Completed Successfully!" -ForegroundColor Green
