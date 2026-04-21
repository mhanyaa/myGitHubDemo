param appName string

resource app 'Microsoft.Web/serverFarms@2023-08-01' = {
  name: '${appName}-plan'
  location: resourceGroup().location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource app 'Microsoft.Web/sites@2023-08-01' = {
  name: appName
  location: resourceGroup().location
  properties: {
    serverFarmId: app.id
    httpsOnly: true
  }
}
