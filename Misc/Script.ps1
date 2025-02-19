$repoUrl = "https://gitlab.com/es-de/emulationstation-de.git"  # Replace with the actual Git repo URL
$destinationFolder = "D:\"      # Change this to your desired location

# Check if the destination folder exists
if (Test-Path -Path $destinationFolder) {
    # If the folder exists, navigate into it and pull the latest version
    Set-Location -Path $destinationFolder
    git pull origin main  # Pull the latest changes from the 'main' branch (adjust if using a different branch)
} else {
    # If the folder doesn't exist, clone the repository
    git clone $repoUrl $destinationFolder
}

Write-Host "The latest version of the Git project has been installed or updated at $destinationFolder"
Pause