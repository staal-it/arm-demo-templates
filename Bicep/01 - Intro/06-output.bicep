resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: 'name'
    location: resourceGroup().location
    kind: 'StorageV2'
    sku: {
        name: 'Premium_LRS'
    }
}

/*
Output can be used in Azure CLI, Azure DevOps, ...
*/
output resourceID string = storageaccount.id
