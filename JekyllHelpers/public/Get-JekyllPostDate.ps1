function Get-JekyllPostDate {
    [CmdletBinding()]
    param(
        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeLine = $true,
            ValueFromPipeLineByPropertyName = $true,
            HelpMessage = "Path to a location.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    $JekyllPostContent = Get-Content -Path $Path
    $Line = 0
    $ReturnDate = $null
    do {
        if ($JekyllPostContent[$Line].StartsWith("date:")) {
            $ReturnDate = $JekyllPostContent[$Line].TrimStart('date:').Trim()
        }
        $Line++
    } until($null -ne $ReturnDate)
    
    return [datetime]$ReturnDate
}
