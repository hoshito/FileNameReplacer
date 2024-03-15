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

    $destinationDir = Split-Path -Path $ResultFilePath
    if (-not (Test-Path $destinationDir)) {
        New-Item -Path $destinationDir -ItemType Directory
    } 

    if (Test-Path $ResultFilePath) {
        $TargetFile = Split-Path -Path $TargetFilePath -Leaf
        Write-Output "already exists ${TargetFile}"
    } else {
        Copy-Item -Path $TargetFilePath -Destination $ResultFilePath
    }
}

function Start-Main {
    param(
        [string]$TargetDirPath,
        [string]$Replacement,
        [string]$NewString
    )

    Get-ChildItem -Path $TargetDirPath -File | ForEach-Object {
        $TargetFile = $($_.Name)
        $ResultFile = Set-ReplaceString -TargetString $TargetFile -OldValue $Replacement -NewValue $NewString

        $TargetFilePath = [System.IO.Path]::GetFullPath("${TargetDirPath}/${TargetFile}")
        $ResultFilePath = [System.IO.Path]::GetFullPath("${TargetDirPath}/../result/${ResultFile}")

        Copy-File -TargetFilePath $TargetFilePath -ResultFilePath $ResultFilePath
    }
}
