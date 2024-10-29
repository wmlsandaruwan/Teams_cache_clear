# Paths for New and Classic Teams
$newTeamsPath = "C:\Users\$env:USERNAME\AppData\Local\Packages\MSTeams_8wekyb3d8bbwe"
$classicTeamsPath = "$env:APPDATA\Microsoft\Teams"

# Subfolders that typically hold cache files and can often be cleared while Teams is running
$cacheSubfolders = @("Cache", "blob_storage", "databases", "GPUCache", "IndexedDB", "Local Storage", "tmp")

# Function to clear specific subfolder contents without displaying errors for missing paths
function Clear-TeamsCacheSubfolders {
    param (
        [string]$basePath
    )

    foreach ($subfolder in $cacheSubfolders) {
        $fullPath = Join-Path -Path $basePath -ChildPath $subfolder
        if (Test-Path -Path $fullPath) {
            Remove-Item -Path "$fullPath\*" -Recurse -Force -ErrorAction SilentlyContinue

            # Confirm clearance only if the folder existed
            if ((Get-ChildItem -Path $fullPath -Recurse -ErrorAction SilentlyContinue).Count -eq 0) {
                Write-Output "Cleared: $fullPath"
            }
            else {
                Write-Output "Failed to clear: $fullPath (Some files might be in use)"
            }
        }
    }
}

# Clear both new and classic Teams paths by targeting subfolders
Clear-TeamsCacheSubfolders -basePath $newTeamsPath
Clear-TeamsCacheSubfolders -basePath $classicTeamsPath

# Confirmation message
Write-Output "Microsoft Teams cache files and app directory cleaned without closing the app."
