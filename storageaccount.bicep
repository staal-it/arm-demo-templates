param name string

var sku = 'Premium_LRS'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: name
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: sku
  }
}

output blobendpoint string = storageaccount.properties.primaryEndpoints.blob
