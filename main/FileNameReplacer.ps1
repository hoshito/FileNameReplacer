function Set-ReplaceString {
    param (
        [string]$TargetString,
        [string]$OldValue,
        [string]$NewValue
    )
    return $TargetString -replace $OldValue, $NewValue
}

function Copy-File {
    param (
        [string]$TargetFilePath,
        [string]$ResultFilePath
    )

    $destinationDir = Split-Path -Path $destinationFile
    if (-not (Test-Path $destinationDir)) {
        New-Item -Path $destinationDir -ItemType Directory
    } 

    if (Test-Path $ResultFilePath) {
        $TargetFile = Split-Path -Path $TargetFilePath -Leaf
        Write-Output "${TargetFile}はコピーできませんでした"
    } else {
        Copy-Item -Path $TargetFilePath -Destination $ResultFilePath
    }
}
