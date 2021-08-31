targetScope = 'subscription'

param systemName string = 'demo'
param environment string = 'tst'

param adminLogin string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${systemName}-${environment}-001'
  location: 'West Europe'
}

module logAnalytics 'OperationalInsights/logAnaltyics.bicep' = {
  scope: resourceGroup
  name: 'logAnalytics'
  params: {
    name: 'log-${systemName}-${environment}-001'
  }
}

module keyVault 'KeyVault/KeyVault.bicep' = {
  scope: resourceGroup
  name: 'keyvault'
  params: {
    name: 'kv-${systemName}-${environment}-001'
    workspaceId: logAnalytics.outputs.id
  }
}

resource existingKeyvault 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: 'existingKeyvault'
  scope: resourceGroup
}

module storage 'Storage.bicep' = {
  scope: resourceGroup
  name: 'storageDeployment'
  params: {
    systemName: systemName
    adminPassword: existingKeyvault.getSecret('sqlPassword')
    adminLogin: adminLogin
    environment: environment
    workspaceResourceId: logAnalytics.outputs.id
  }
}

module appService 'WebApp.bicep' = {
  scope: resourceGroup
  name: 'appServiceDeployment'
  params: {
    systemName: systemName
    environment: environment
    workspaceResourceId: logAnalytics.outputs.id
  }
}
