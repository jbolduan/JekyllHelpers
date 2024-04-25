function New-JekyllPost {
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

        [Parameter(Mandatory = $true,
            Position = 1,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "The name of the post.")]
        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [Parameter()]
        [string[]]$Categories,

        [Parameter()]
        [string[]]$Tags,

        [Parameter()]
        [datetime]$PubDate = (Get-Date)
    )

    $Header = "---`n"
    $Header += "title: $Title`n"
    $Header += "date: $($PubDate | Get-Date -Format 'yyyy-MM-dd hh:mm:ss') $(($PubDate | Get-Date -Format 'zzzz').Replace(':', ''))`n"
    
    if ($null -ne $Categories) {
        $Header += "Categories:"
        foreach ($Category in $Categories) {
            $Header += " $Category"
        }
        $Header += "`n"
    }

    if ($null -ne $Tags) {
        $Header += "Tags:"
        foreach ($Tag in $Tags) {
            $Header += " $Tag"
        }
        $Header += "`n"
    }

    $Header += "---`n"

    Set-Content -Path "$Path\$($PubDate | Get-Date -Format 'yyyy-MM-dd')-$($Title.Replace(' ', '-')).md" -Value $Header -Force 
}
