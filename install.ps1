# PowerShell Script to Download gub.exe and Add it to PATH

# Step 1: Define variables
$gubFolder = "C:\GubTool"
$gubUrl = "https://github.com/kayesFerdous/test/releases/download/v1.0.1/gub.exe"  # Replace with real link
$exePath = "$gubFolder\gub.exe"

# Step 2: Create target directory if it doesn't exist
if (!(Test-Path -Path $gubFolder)) {
    New-Item -ItemType Directory -Path $gubFolder -Force
}

# Step 3: Download gub.exe
Invoke-WebRequest -Uri $gubUrl -OutFile $exePath

# Step 4: Add to system PATH (if not already in PATH)
$envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if (-not $envPath.Split(";") -contains $gubFolder) {
    [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$gubFolder", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "✔️ Added $gubFolder to system PATH."
} else {
    Write-Host "ℹ️ $gubFolder is already in system PATH."
}

# Step 5: Done
Write-Host "`n🎉 Done! You can now run 'gub.exe' from anywhere. Please restart Command Prompt or your system to apply PATH changes."
