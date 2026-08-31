# PF 2026 - One-click C++ setup: VS Code + MinGW compiler + C++ extension
Write-Host "Setting up your C++ environment..." -ForegroundColor Cyan

# 1. Install VS Code
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "Installing VS Code..." -ForegroundColor Yellow
    winget install -e --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements
} else {
    Write-Host "VS Code already installed. Skipping." -ForegroundColor Green
}

# 2. Install Chocolatey (needed for MinGW)
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey already installed. Skipping." -ForegroundColor Green
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 3. Install MinGW (GCC/G++ compiler)
Write-Host "Installing MinGW (GCC/G++)..." -ForegroundColor Yellow
choco install mingw -y

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 4. Install C++ extension for VS Code
Write-Host "Installing VS Code C++ extension..." -ForegroundColor Yellow
code --install-extension ms-vscode.cpptools --force

Write-Host ""
Write-Host "All done! Close and reopen VS Code / terminal." -ForegroundColor Cyan
Write-Host "Check it worked: g++ --version" -ForegroundColor Cyan
