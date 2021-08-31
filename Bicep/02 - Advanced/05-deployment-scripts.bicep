/*
These scripts can be used for performing custom steps such as:

- Perform data plane operations, for example, copy blobs or seed database
- Create a self-signed certificate
- Create an object in Azure AD
- Look up a value from a custom system
*/

resource dScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
    name: 'scriptWithStorage'
    location: 'West Europe'
    kind: 'AzureCLI'
    identity: {
        type: 'UserAssigned'
        userAssignedIdentities: {
            '/subscriptions/01234567-89AB-CDEF-0123-456789ABCDEF/resourceGroups/myResourceGroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myID': {}
        }
    }
    properties: {
        azCliVersion: '2.0.80'
        storageAccountSettings: {
            storageAccountName: 'myStorageAccount'
            storageAccountKey: 'myKey'
        }
        arguments: '-name "John Dole"'
        environmentVariables: [
            {
                name: 'someSecret'
                secureValue: 'if this is really a secret, dont put it here... in plain text...'
            }
        ]
        scriptContent: 'date' // or "primaryScriptUri": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/deployment-script/deploymentscript-helloworld.ps1"
        retentionInterval: 'P1D'
    }
}
