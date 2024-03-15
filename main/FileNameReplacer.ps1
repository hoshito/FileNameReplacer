function Set-ReplaceString {
    param (
        [string]$TargetString,
        [string]$OldValue,
        [string]$NewValue
    )
    return $TargetString -replace $OldValue, $NewValue
}
