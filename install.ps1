
# Set target folder and URL
$gubFolder = "$env:USERPROFILE\GubTool"
$gubUrl = "https://github.com/kayesFerdous/test/releases/download/v1.0.1/gub.exe"  # Replace with real link
$exePath = "$gubFolder\gub.exe"

# Create folder if it doesn't exist
if (!(Test-Path -Path $gubFolder)) {
    New-Item -ItemType Directory -Path $gubFolder -Force | Out-Null
}

# Download gub.exe
Invoke-WebRequest -Uri $gubUrl -OutFile $exePath -UseBasicParsing

# Add folder to USER PATH if it's not already there
$userPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

if (-not ($userPath -split ";" | ForEach-Object { $_.Trim() }) -contains $gubFolder) {
    $newUserPath = "$userPath;$gubFolder"
    [System.Environment]::SetEnvironmentVariable("Path", $newUserPath, "User")
    Write-Host "✅ Added $gubFolder to USER PATH."
} else {
    Write-Host "ℹ️ $gubFolder already in PATH."
}

Write-Host "`n🎉 Done! Please restart PowerShell or Command Prompt to use 'gub.exe' from anywhere."
