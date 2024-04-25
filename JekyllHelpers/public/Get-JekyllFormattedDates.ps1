function Get-JekyllFormattedDates {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [DateTime]$Date = (Get-Date)
    )

    return @{
        "PostMetadata"     = "$($Date | Get-Date -Format 'yyyy-MM-dd hh:mm:ss') $(($Date | Get-Date -Format 'zzzz').Replace(':', ''))`n"
        "PostFileNameDate" = "$($Date | Get-Date -Format 'yyyy-MM-dd')"
    }
}
