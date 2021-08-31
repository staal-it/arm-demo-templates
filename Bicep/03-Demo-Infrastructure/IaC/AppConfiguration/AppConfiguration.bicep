param name string
param sku string = 'free'

param location string = resourceGroup().location = resourceGroup().location

resource appConfiguration 'Microsoft.AppConfiguration/configurationStores@2021-03-01-preview' = {
    name: name
    location: location
    sku: {
        name: sku
    }
}
