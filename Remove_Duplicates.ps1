param(
    # $folderPath (*Required*) -> The root folder
    [string]$folderPath,

    # $Recurse Flag (*Optional*) -> Traverse sub-folders? 'False' by default
    [switch]$Recurse
)

function GetFileHash($filePath) {

    # Uses MD5 because faster than SHA256
    $hasher = [System.Security.Cryptography.MD5]::Create()

    # Open file stream to read contents of file
    $fileStream = [System.IO.File]::OpenRead($filePath)
    
    # Computes MD5 hash of the file
    $hashBytes = $hasher.ComputeHash([System.IO.Stream]$fileStream)

    # Finish hash compute, close the file stream
    $fileStream.Close()

    # Convert hash bytes to string
    $hashString = [BitConverter]::ToString($hashBytes)

    return $hashString
}

function RemoveDuplicates($folderPath, $includeSubFolders) {

    # Stores hash values as keys and file paths as values
    $fileHashes = @{}
    
    Get-ChildItem -Path $folderPath -Recurse:$includeSubFolders | ForEach-Object {

        $filePath = $_.FullName

        # Skip folders/sub-folders to avoid OpenRead() on folders which will cause errors
        if ($_.PSIsContainer) {
            return
        }
    
        $hash = GetFileHash -filePath $filePath
        
        # Checks if hash already in hashtable
        if ($fileHashes.ContainsKey($hash)) {
            # Duplicate hash found
            Write-Host "Duplicate found: $_"
            Remove-Item -Path $_.FullName -Force
        } else {
            # New file. Add to hashtable
            $fileHashes[$hash] = $filePath
        }
    }
}

# Check if folder path exists
if (Test-Path $folderPath) {
    RemoveDuplicates -folderPath $folderPath -includeSubFolders $Recurse
    Write-Host "Finished....."
} else {
    Write-Host "Invalid folder path: $folderPath"
}
