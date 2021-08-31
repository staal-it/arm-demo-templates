param name string
param location string = resourceGroup().location
param workspaceResourceId string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: name
    location: location
    kind: 'StorageV2'
    sku: {
        name: 'Premium_LRS'
    }
    properties: {
        supportsHttpsTrafficOnly: true
    }
}

resource storageAccountDiagnosticSetting 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
    scope: storageaccount
    name: 'Send to loganalytics'
    properties: {
       workspaceId: workspaceResourceId
       metrics: [
         {
           category: 'Transaction'
           enabled: true
         }
       ]
    }
  }
