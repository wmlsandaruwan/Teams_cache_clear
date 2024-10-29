# Get the current user's profile path
$UserProfile = $env:USERPROFILE

# Define the Teams cache folder path using the user's profile
$TeamsCachePath = Join-Path -Path $UserProfile -ChildPath "AppData\Roaming\Microsoft\Teams"

# List of cache folders to clear
$CacheFolders = @(
    "blob_storage",
    "Cache",
    "databases",
    "GPUCache",
    "IndexedDB",
    "Local Storage",
    "tmp"
)

# Check if Teams cache folder exists
if (Test-Path -Path $TeamsCachePath) {
    foreach ($Folder in $CacheFolders) {
        $CacheFolderPath = Join-Path -Path $TeamsCachePath -ChildPath $Folder
        if (Test-Path -Path $CacheFolderPath) {
            Remove-Item -Path $CacheFolderPath -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Cleared cache in: $CacheFolderPath"
        } else {
            Write-Host "Cache folder not found: $CacheFolderPath"
        }
    }
    Write-Host "Microsoft Teams cache cleared successfully."
} else {
    Write-Host "Teams cache folder not found. Microsoft Teams may not be installed for the current user."
}
