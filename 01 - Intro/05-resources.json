{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "appServicePlanName": {
            "type": "string"
        },
        "webappname": {
            "type": "string"
        },
        "useManagedIdentity": {
            "type": "bool",
            "defaultValue": true
        },
        "location": {
            "type": "string"
        }
    },
    "resources": [
        {
            "type": "Microsoft.Web/serverfarms",
            "apiVersion": "2015-08-01",
            "name": "[parameters('appServicePlanName')]",
            "kind": "linux",
            "location": "[parameters('location')]",
            "sku": {
                "name": "S1",
                "capacity": 1
            },
            "properties": {
                "name": "[parameters('appServicePlanName')]",
                "workerSizeId": "1",
                "reserved": true,
                "numberOfWorkers": 1
            }
        },
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('webappname')]",
            "type": "Microsoft.Web/sites",
            "location": "[parameters('location')]",
            "kind": "app,linux",
            "identity": {
                "type": "[if(parameters('useManagedIdentity'), 'SystemAssigned', 'None')]"
            },
            "properties": {
                "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', parameters('appServicePlanName'))]"
            }
        }
    ]
}