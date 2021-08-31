targetScope = 'subscription'    // <-- setting the scope of the deployment

param systemName string = 'demo'
param environment string = 'tst'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${systemName}-${environment}-001'
  location: 'West Europe'
}

module logAnalytics '../03-Demo-Infrastructure/IaC/OperationalInsights/logAnaltyics.bicep' = {
  scope: resourceGroup    // <-- changing the scope within the deployment
  name: 'logAnalytics'
  params: {
    name: 'log-${systemName}-${environment}-001'
  }
}

module keyVault '../03-Demo-Infrastructure/IaC/KeyVault/KeyVault.bicep' = {
  scope: resourceGroup
  name: 'keyvault'
  params: {
    name: 'kv-${systemName}-${environment}-001'
    workspaceId: logAnalytics.outputs.id
  }
}
