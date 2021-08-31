param storageAccounts array = [
    {
        name: 'MyStorage'
        kind: 'StorageV2'
        sku: {
            name: 'Standard_LRS'
            tier: 'Standard'
        }
    }
    {
        name: 'Logs'
        kind: 'StorageV2'
        sku: {
            name: 'Standard_LRS'
            tier: 'Standard'
        }
    }
]
// Loop on resource level
resource stg 'Microsoft.Storage/storageAccounts@2021-02-01' = [for storageAccount in storageAccounts: {
    name: storageAccount.name
    location: resourceGroup().location
    kind: storageAccount.kind
    sku: storageAccount.sku
}]



// Loop on properties level
var subnets = [
    {
        name: 'api'
        subnetPrefix: '10.144.0.0/24'
    }
    {
        name: 'worker'
        subnetPrefix: '10.144.1.0/24'
    }
]

resource vnet 'Microsoft.Network/virtualNetworks@2018-11-01' = {
    name: 'vnet'
    location: resourceGroup().location
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.144.0.0/20'
            ]
        }
        subnets: [for subnet in subnets: {
            name: subnet.name
            properties: {
                addressPrefix: subnet.subnetPrefix
            }
        }]
    }
}
