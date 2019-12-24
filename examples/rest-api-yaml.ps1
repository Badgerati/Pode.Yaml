<#
    This example can be started as follows:

    > pode install
    > pode start
#>
Start-PodeServer -Threads 2 {

    # listen on localhost:8090
    Add-PodeEndpoint -Address * -Port 8090 -Protocol Http

    # import the YAML module
    Import-PodeModule -Name Pode.Yaml -Now

    # enable YAML requests
    Enable-PodeYamlBodyParser

    Add-PodeRoute -Method Post -Path '/' -ScriptBlock {
        param($e)
        Write-PodeYamlResponse -Value @{ Name = $e.Data.name; Numbers = @(1,2,3) }
    }

}