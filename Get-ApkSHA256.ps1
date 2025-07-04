param (
    [string]$apk = "app/release/app-release.apk"
)

# Run apksigner (must be in your PATH)
$certOutput = & apksigner.bat verify --print-certs $apk

# Extract SHA-256
$shaLine = ($certOutput | Select-String "SHA-256").ToString()
$hex = ($shaLine -split ":")[1..99] -join "" -replace "[:\s]", ""

# Convert hex to byte array
$bytes = for ($i=0; $i -lt $hex.Length; $i+=2) { [Convert]::ToByte($hex.Substring($i,2),16) }

# Encode to base64
$base64 = [System.Convert]::ToBase64String($bytes)
Write-Host "Base64 for provisioning JSON:"
Write-Host $base64
