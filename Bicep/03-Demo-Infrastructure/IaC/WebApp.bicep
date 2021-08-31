param systemName string
param environment string
param workspaceResourceId string

module appInsights 'Insights/ApplicationInsights.bicep' = {
  name: 'appInsights'
  params: {
    name: 'appi-${systemName}-${environment}-001'
    workspaceResourceId: workspaceResourceId
  }
}

module appServicePlan 'WebApp/Serverfarm.bicep' = {
  name: 'appServicePlan'
  params: {
    name: 'plan-${systemName}-${environment}-001'
  }
}

module appService 'WebApp/WebApp.bicep' = {
  name: 'appService'
  params: {
    name: 'app-${systemName}-${environment}-001'
    serverFarmId: appServicePlan.outputs.id
  }
}
