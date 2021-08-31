// Built-in function
//Array functions
//    contains()
//    empty()
//Comparison functions
//    equals()
//    greater()
//Date functions
//    utcNow()
//Deployment value functions
//    parameters()
//Logical functions
//    if()
//    and()
//    or()
//Numeric functions
//    int()
//    max()
//    min()
//Object functions
//    contains()
//    empty()
//    union()
//Resource functions
//    resourceId()
//    resourceGroup()
//    subscription()
//    listKeys()
//String functions
//    length()
//    toLower()



// **********  KV Exmaple **********
param sqlServerName string
param adminLogin string

param subscriptionId string
param kvResourceGroup string
param kvName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

module sql '../02%20-%20Advanced/04-secrets.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: sqlServerName
    adminLogin: adminLogin
    adminPassword: kv.getSecret('vmAdminPassword')
  }
}

// **********  STG Exmaple **********

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
    name: 'dscript${uniqueString(resourceGroup().id)}'
    location: 'West Europe'
    kind: 'StorageV2'
    sku: {
      name: 'Standard_LRS'
    }
  }

  resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
    name: 'keyVaultName/storagekey'
    properties: {
      value: stg.listKeys().keys[0].value
      // ARM "[listKeys(resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName')), '2019-06-01').keys[0].value]"
    }
  }

// custom functions
// Not in Bicep!
