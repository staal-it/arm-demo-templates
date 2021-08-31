param name string
param workspaceId string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    enabledForDeployment: false
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
    tenantId: subscription().tenantId
    enableSoftDelete: true
    softDeleteRetentionInDays: 30
    enablePurgeProtection: true
    enableRbacAuthorization: true
    accessPolicies: [ ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource kvDiagnosticSetting 'microsoft.insights/diagnosticSettings@2017-05-01-preview' = {
  scope: keyVault
  name: 'Send to loganalytics'
  properties: {
     workspaceId: workspaceId
     logs: [
       {
         category: 'AuditEvent'
         enabled: true
       }        
     ]
     metrics: [
       {
         category: 'AllMetrics'
         enabled: true
       }
     ]
  }
}
