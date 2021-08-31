

// **********  Secure string Exmaple **********
param sqlServerName string = 'sqlServer'
param adminLogin string

@secure()                   // <-- secure string using an attribute
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}


// **********  KV Exmaple **********
param subscriptionId string
param kvResourceGroup string
param kvName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

module sql '../03-Demo-Infrastructure/IaC/Sql/SqlServer.bicep' = {
  name: 'deploySQL'
  params: {
    name: sqlServerName
    adminLogin: adminLogin
    adminPassword: kv.getSecret('vmAdminPassword')     // <-- using a new function on the KeyVault, check how that transpiles
  }
}
