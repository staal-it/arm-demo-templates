param adminUsername string

@secure()
param adminPassword string
param publicIpName string
param OSVersion string
param vmSize string
param location string
param vmName string

var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var nicName = 'myVMNic'

resource vmName_resource 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: OSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', nicName)
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: reference(resourceId('Microsoft.Storage/storageAccounts', storageAccountName)).primaryEndpoints.blob
      }
    }
  }
  dependsOn: [
    resourceId('Microsoft.Storage/storageAccounts', storageAccountName)
    resourceId('Microsoft.Network/networkInterfaces', nicName)
  ]
}

resource vmName_InstallWebServer 'Microsoft.Compute/virtualMachines/extensions@2019-12-01' = {
  parent: vmName_resource
  name: 'InstallWebServer'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/tutorial-vm-extension/installWebServer.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File installWebServer.ps1'
    }
  }
}

output hostname string = reference(publicIpName).dnsSettings.fqdn