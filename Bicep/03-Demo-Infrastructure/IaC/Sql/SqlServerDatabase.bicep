param name string
param sqlServerName string
param elasticPoolId string
param location string = resourceGroup().location

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: '${name}/${sqlServerName}'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    elasticPoolId: elasticPoolId
  }
}
