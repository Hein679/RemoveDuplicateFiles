## Powershell script for deleting duplicate files
### Options
**$folderPath** [required] <br>
**$Recurse** [optional] <br>
**$NoDelete** [optional]

## How To Use
### Delete duplicates in current folder
Remove_Duplicates.ps1 -folderPath ".\Test Folder\"
### Delete duplicates current folder and all sub-folders
Remove_Duplicates.ps1 -folderPath ".\Test Folder\" -Recurse 
### Don't delete, just print out duplicate file paths
Remove_Duplicates.ps1 -folderPath ".\Test Folder\" -Recurse -NoDelete