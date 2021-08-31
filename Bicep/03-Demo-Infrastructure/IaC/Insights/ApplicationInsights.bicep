param name string
param workspaceResourceId string

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: resourceGroup().location
  kind: 'web'

  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspaceResourceId
  }
}
