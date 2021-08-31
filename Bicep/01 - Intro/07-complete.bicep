param storageNamePrefix string

@allowed([
    'Standard_LRS'
    'Standard_GRS'
    'Standard_RAGRS'
    'Premium_LRS'
])
param storageSKU string = 'Standard_LRS'

var storageName = '${toLower(storageNamePrefix)}${uniqueString(resourceGroup().id)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: storageName
    location: resourceGroup().location
    kind: 'StorageV2'
    sku: {
        name: storageSKU
    }
}

output resourceID string = storageaccount.id
