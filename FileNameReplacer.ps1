function Add-Numbers {
    param (
        [int]$Number1,
        [int]$Number2
    )

    $Sum = $Number1 + $Number2
    return $Sum
}

# $Result = Add-Numbers -Number1 5 -Number2 7
# Write-Host "The result is: $Result"