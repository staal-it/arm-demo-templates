param name string

@allowed([
  'PerGB2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
param sku string = 'PerGB2018'

param retentionInDays int = 120

param resourcePermissions bool = true

resource logAnaltyicsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: resourcePermissions
    }
  }
}

output id string = logAnaltyicsWorkspace.id
