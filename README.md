# Pode YAML

This is an extension module for the [Pode](https://github.com/Badgerati/Pode) web server (v1.3.0+). It allows you to parse and send YAML requests and responses.

## Install

> Note: this module has a dependency on the [powershell-yaml](https://www.powershellgallery.com/packages/powershell-yaml/0.4.1) module

You can either install this module globally:

```powershell
Install-Module -Name powershell-yaml
Install-Module -Name Pode.Yaml
```

or you can let Pode install it for you locally, by adding the following into your `package.json`:

```json
"modules": {
    "powershell-yaml": "latest",
    "pode.yaml": "latest"
}
```

## Usage

### Body Parser

You'll need to first import the module, and then enable it as a body-parser within your server's scriptblock:

```powershell
Import-PodeModule -Name Pode.Yaml -Now
Enable-PodeYamlBodyParser
```

### Response

You can respond back with YAML in a Route as follows:

```powershell
Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
    Write-PodeYamlResponse -Value @{ Name = 'example' }
}
```

### Content Type

The default content type expected on the request, and used on the response is `application/x-yaml`. You can change this by specifying the `-ContentType` parameter on the above `PodeYaml` functions.
