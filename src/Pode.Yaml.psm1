# ensure the powershell-yaml module is imported
if ($null -eq (Get-Module -Name 'powershell-yaml' -ErrorAction Ignore)) {
    Import-PodeModule -Name 'powershell-yaml' -Now
}

# root path to module
$root = Split-Path -Parent -Path $MyInvocation.MyCommand.Path

# get existing functions from memory for later comparison
$sysfuncs = Get-ChildItem Function:

# load public functions
Get-ChildItem "$($root)/Public/*.ps1" | Resolve-Path | ForEach-Object { . $_ }

# get functions from memory and compare to existing to find new functions added
$funcs = Get-ChildItem Function: | Where-Object { $sysfuncs -notcontains $_ }

# export the module's public functions
Export-ModuleMember -Function ($funcs.Name)