param storageNamePrefix string

var storageName = '${toLower(storageNamePrefix)}${uniqueString(resourceGroup().id)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: storageName
    location: resourceGroup().location
    kind: 'StorageV2'
    sku: {
        name: 'Premium_LRS'
    }
}
