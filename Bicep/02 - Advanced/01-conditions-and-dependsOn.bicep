param sqlServerName string = 'sqlServer'
param allowAzureIPs bool

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: 'administratorLoginPassword'
  }

  // sub-resource <-- we can have a resource specified as subresource
  resource sqlServerFirewallRulesChild 'firewallRules@2020-11-01-preview' = if(allowAzureIPs) {  // <-- using a condition
    name: 'childWithinParent'
    properties: {
      startIpAddress: 'startIpAddress'
      endIpAddress: 'endIpAddress'
    }
  }
}

// child defined at the root scope using the 'parent' keyword
resource sqlServerFirewallRulesParent 'Microsoft.Sql/servers/firewallRules@2020-11-01-preview' = if(allowAzureIPs) {
  parent: sqlServer
  name: 'child'
  properties: {
    startIpAddress: 'startIpAddress'
    endIpAddress: 'endIpAddress'
  }
}
