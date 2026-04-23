targetScope = 'subscription'

param location string = 'westeurope'
param env string = 'dev'

var prefix = 'demo${env}'

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${prefix}'
  location: location
}

module network 'modules/network.bicep' = {
  name: 'network'
  scope: rg
  params: {
    vnetName: 'vnet-${prefix}'
    location: location
  }
}

module kv 'modules/keyvault.bicep' = {
  name: 'kv'
  scope: rg
  params: {
    kvname: 'kv-${prefix}01'
    location: location
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storage'
  scope: rg
  params: {
    storageName: 'st${uniqueString(prefix)}'
    location: location
  }
}

module app 'modules/app.bicep' = {
  name: 'app'
  scope: rg
  params: {
    appName: 'app-${prefix}'
    location: location
  }
}

