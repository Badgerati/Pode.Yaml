# Pode YAML

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Badgerati/Pode.Yaml/master/LICENSE.txt)
[![Gitter](https://badges.gitter.im/Badgerati/Pode.svg)](https://gitter.im/Badgerati/Pode?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![PowerShell](https://img.shields.io/powershellgallery/dt/pode.yaml.svg?label=PowerShell&colorB=085298)](https://www.powershellgallery.com/packages/Pode.Yaml)

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

You can set this module to be used to parse Request payloads, that have relevant Content-Type. You'll need to first import the module, and then enable it as a body-parser within your server's scriptblock:

```powershell
Import-PodeModule -Name Pode.Yaml -Now
Enable-PodeYamlBodyParser
```

When the parser runs it will either set the event's `Data` object to be:

* A single hashtable - if one YAML document is supplied
* An array of hashtables - if multiple YAML documents are supplied

For example, if a Request comes in with the following payload:

```yaml
---
name: bob
```

Then you can access the `name` in a Route via the event parameters `Data` object:

```powershell
Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
    param($e)
    $e.Data.name | Out-PodeHost
}
```

Or if the request had multiple documents:

```yaml
---
name: bob

---
name: bill
```

Then the second `name` is accessible as follows:

```powershell
Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
    param($e)
    $e.Data[0].name | Out-PodeHost
}
```

### Response

You can respond back with YAML in a Route as follows:

```powershell
Add-PodeRoute -Method Get -Path '/' -ScriptBlock {
    Write-PodeYamlResponse -Value @{ Name = 'bob' }
}
```

This will write back to the client the follow payload:

```yaml
name: bob
```

### Content Type

The default Content-Type expected on the request, and used on the response is `application/x-yaml`. You can change this by specifying the `-ContentType` parameter on the above `PodeYaml` functions.
