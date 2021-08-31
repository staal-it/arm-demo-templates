param adminLogin string
@secure()
param adminPassword string

param systemName string
param environment string

param workspaceResourceId string

var sqlServerName = 'sql-${systemName}-${environment}-001'

module sqlServer 'Sql/SqlServer.bicep' = {
  name: 'sqlServer'
  params: {
    adminLogin: adminLogin
    adminPassword: adminPassword
    name: sqlServerName
  }
}

module sqlElasticPool 'Sql/SqlElasticPool.bicep' = {
  name: 'sqlElasticPool'
  params: {
    elasticpoolSettings: {
    }
    name: 'pool-${systemName}-${environment}-001'
    sqlServerName: sqlServerName
  }
}

module sqlDb 'Sql/SqlServerDatabase.bicep' = {
  name: 'sqlDb'
  params: {
    elasticPoolId: sqlElasticPool.outputs.id
    name: 'sqldb-${systemName}-${environment}-001'
    sqlServerName: sqlServerName
  }
}

module storage 'Storage/StorageAccountV2.bicep' = {
  name: 'storage'
  params: {
    name: 'stg${systemName}${environment}001'
    workspaceResourceId: workspaceResourceId
  }
}
