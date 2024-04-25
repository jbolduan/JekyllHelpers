@{
    RootModule        = 'JekyllHelpers.psm1'
    ModuleVersion     = '{version}'
    GUID              = 'f374c8e6-b863-460b-b81b-eb0fcea3fd91'
    Author            = 'Jeff Bolduan'
    CompanyName       = 'Jeff Bolduan'
    Copyright         = '(c) 2022 Jeff Bolduan.  All rights reserved.'
    Description       = 'A module containing functions to help working with a Jekyll site.'
    PowerShellVersion = '7.0'
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    PrivateData       = @{
        PSData = @{
            Tags         = @('jekyll', 'automation', 'helper')
            LicenseUri   = ''
            ProjectUri   = ''
            IconUri      = ''
            ReleaseNotes = ''
            Prerelease   = '{prerelease}'
        }
    }
}
