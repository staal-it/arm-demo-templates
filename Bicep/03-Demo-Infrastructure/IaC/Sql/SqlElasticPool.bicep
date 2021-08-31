param name string
param sqlServerName string
param elasticpoolSettings object

param location string = resourceGroup().location

resource elasticPool 'Microsoft.Sql/servers/elasticPools@2021-02-01-preview' = {
    name: '${sqlServerName}/${name}'
    location: location
    sku: {
        name: elasticpoolSettings.sku.name
        tier: elasticpoolSettings.sku.tier
        capacity: elasticpoolSettings.sku.capacity
    }
     properties: {
         maxSizeBytes: elasticpoolSettings.maxSizeBytes
         perDatabaseSettings: {
             maxCapacity: elasticpoolSettings.databaseDtuMax
             minCapacity: elasticpoolSettings.databaseDtuMin
         }
     }
}

output id string = elasticPool.id
