param name string
param location string = resourceGroup().location

resource hosting 'Microsoft.Web/serverfarms@2019-08-01' = {
  name: name
  location: location
  sku: {
    name: 'S1'
  }
}

output id string = hosting.id
