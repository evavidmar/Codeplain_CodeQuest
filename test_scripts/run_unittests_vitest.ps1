#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$UNRECOVERABLE_ERROR_EXIT_CODE = 69

# Step 1: Toolchain check
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Node.js is not installed."
    exit $UNRECOVERABLE_ERROR_EXIT_CODE
}

if (-not (Get-Command "npm" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: npm is not installed."
    exit $UNRECOVERABLE_ERROR_EXIT_CODE
}

# Step 2: Argument validation
if (-not $args[0]) {
    Write-Host "Error: No subfolder name provided."
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <subfolder_name>"
    exit 1
}

$BuildFolder = $args[0]

# Step 3: Working directory setup
$WORKING_FOLDER = ".tmp/vitest_$BuildFolder"

if (Test-Path $WORKING_FOLDER) {
    Get-ChildItem -Path $WORKING_FOLDER -Force |
        Where-Object { $_.Name -ne "node_modules" -and $_.Name -ne "package-lock.json" } |
        Remove-Item -Recurse -Force
    Write-Host "Cleaned working folder: $WORKING_FOLDER"
} else {
    New-Item -ItemType Directory -Path $WORKING_FOLDER -Force | Out-Null
    Write-Host "Created working folder: $WORKING_FOLDER"
}

# Step 4: Copy the build
Copy-Item -Path "$BuildFolder/*" -Destination $WORKING_FOLDER -Recurse -Force
$AssetDest = "$WORKING_FOLDER/public/assets"
if (-not (Test-Path $AssetDest)) { New-Item -ItemType Directory -Path $AssetDest -Force | Out-Null }
Copy-Item -Path "pixel-agents-public-assets/public/assets/*" -Destination $AssetDest -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Copied from $BuildFolder to $WORKING_FOLDER"

# Step 5: Enter the working directory
if (-not (Test-Path $WORKING_FOLDER)) {
    Write-Host "Error: Working folder '$WORKING_FOLDER' does not exist."
    exit 2
}

Push-Location $WORKING_FOLDER

try {
    # Step 6: Install dependencies
    Write-Host "Installing dependencies into $WORKING_FOLDER..."
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: npm install failed with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }

    # Step 7: Run the tests via Vitest
    Write-Host "Running Vitest unit tests in $BuildFolder..."
    $ErrorActionPreference = 'Continue'
    npx --yes vitest run --reporter=verbose 2>&1 | ForEach-Object {
        if ($_ -is [System.Management.Automation.ErrorRecord]) { Write-Host $_.Exception.Message } else { Write-Host $_ }
    }
    $TEST_EXIT_CODE = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'

    if ($TEST_EXIT_CODE -ne 0) {
        Write-Host "Error: Tests failed with exit code $TEST_EXIT_CODE"
    }

    exit $TEST_EXIT_CODE
} finally {
    Pop-Location
}
