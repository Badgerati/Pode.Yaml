function Enable-PodeYamlBodyParser
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidatePattern('^\w+\/[\w\.\+-]+$')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ContentType = 'application/x-yaml'
    )

    Get-PodeYamlBodyParser | Add-PodeBodyParser -ContentType $ContentType
}

function Get-PodeYamlBodyParser
{
    [CmdletBinding()]
    param()

    return {
        param($body)
        return ($body | ConvertFrom-Yaml)
    }
}

function Write-PodeYamlResponse
{
    [CmdletBinding(DefaultParameterSetName='Value')]
    param (
        [Parameter(Mandatory=$true, ParameterSetName='Value')]
        $Value,

        [Parameter(Mandatory=$true, ParameterSetName='File')]
        [string]
        $Path,

        [Parameter()]
        [ValidatePattern('^\w+\/[\w\.\+-]+$')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ContentType = 'application/x-yaml',

        [Parameter()]
        [int]
        $StatusCode = 200
    )

    switch ($PSCmdlet.ParameterSetName.ToLowerInvariant()) {
        'file' {
            if (Test-PodePath $Path) {
                $Value = Get-PodeFileContent -Path $Path
            }
        }

        'value' {
            if ($Value -isnot [string]) {
                $Value = ($Value | ConvertTo-Yaml)
            }
        }
    }

    Write-PodeTextResponse -Value $Value -ContentType $ContentType -StatusCode $StatusCode
}