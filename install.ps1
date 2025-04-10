
# Set target folder and URL
$gubFolder = "C:\GubTool"
$gubUrl = "https://github.com/kayesFerdous/test/releases/download/v1.0.1/gub.exe"  # Replace with real link
$exePath = "$gubFolder\gub.exe"

# Create folder if it doesn't exist
if (!(Test-Path -Path $gubFolder)) {
    New-Item -ItemType Directory -Path $gubFolder -Force | Out-Null
}

# Download gub.exe
Invoke-WebRequest -Uri $gubUrl -OutFile $exePath -UseBasicParsing

# Get current system PATH
$systemPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)

Write-Host "`nCurrent System PATH: $systemPath"

# Add folder to system PATH if not already present
if (-not ($systemPath -split ";" | ForEach-Object { $_.Trim() }) -contains $gubFolder) {
    $newSystemPath = "$systemPath;$gubFolder"
    
    try {
        [Environment]::SetEnvironmentVariable("Path", $newSystemPath, [EnvironmentVariableTarget]::Machine)
        Write-Host "✅ Added $gubFolder to SYSTEM PATH."
    }
    catch {
        Write-Host "❌ Error: $_"
    }
} else {
    Write-Host "ℹ️ $gubFolder is already in SYSTEM PATH."
}

Write-Host "`n🎉 Done! Please restart your terminal or log out and back in to use 'gub' globally."
