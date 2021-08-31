param name string
param location string = resourceGroup().location
param serverFarmId string

resource app 'Microsoft.Web/sites@2018-11-01' = {
    name: name
    location: location
    properties: {
        serverFarmId: serverFarmId
    }
}
