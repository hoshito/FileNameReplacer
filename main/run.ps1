# import
$targetScript = Join-Path -Path $PSScriptRoot -ChildPath "./FileNameReplacer.ps1"
. $targetScript

Start-Main -TargetDirPath $args[0] -Replacement $args[1] -NewString $args[2]
