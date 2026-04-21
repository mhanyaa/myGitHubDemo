param appName string
param location string = resourceGroup().location

resource appPlan 'Microsoft.Web/serverFarms@2024-11-01' = {
  name: '${appName}-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource appSite 'Microsoft.Web/sites@2024-11-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appPlan.id
    httpsOnly: true
  }
}
