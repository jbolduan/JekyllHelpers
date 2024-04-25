function Set-JekyllPostDate {
    [CmdletBinding()]
    param(
        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Path to a location.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,
        
        [Parameter(Mandatory = $false, Position = 0)]
        [DateTime]$Date = (Get-Date)
    )

    $JekyllDates = Get-JekyllFormattedDates -Date $Date

    $JekyllPostContent = Get-Content -Path $Path
    $Line = 0
    $DateFound = $false
    $TitleFound = $false
    $PostTitle = ""
    do {
        if ($null -ne $JekyllPostContent[$Line]) {
            if ($JekyllPostContent[$Line].StartsWith("date:")) {
                $JekyllPostContent[$Line] = "date: $($JekyllDates.PostMetadata.Trim())"
                $DateFound = $true
            }

            if ($JekyllPostContent[$Line].StartsWith("title:")) {
                $PostTitle = $JekyllPostContent[$Line].TrimStart("title:").Trim().Trim('"')
            }
        }

        $Line++
    } until(($DateFound -and $TitleFound) -or ($Line -gt $JekyllPostContent.Count))

    Set-Content -Path $Path -Value $JekyllPostContent -Force

    Rename-Item -Path $Path -NewName "$($JekyllDates.PostFileNameDate.Trim())-$($PostTitle.Replace(' ', '-')).md"
}
