# Parameters - 
# $folderPath *required
# $Recurse *optional
# $NoDelete *optional

# Run the command in PowerShell
# Delete duplicate files permanently
.\Remove_Duplicates.ps1 -folderPath ".\Test Folder\" -Recurse 

# Don't delete, just print out duplicate files' paths
.\Remove_Duplicates.ps1 -folderPath ".\Test Folder\" -Recurse -NoDelete

