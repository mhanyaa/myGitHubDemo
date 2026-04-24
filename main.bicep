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

module spoke1 'modules/spoke.bicep' = {
  name: 'spoke1Deploy'
  scope: rg
  params: {
    vnetName: 'vnet-spoke-app'
    addressPrefix: '10.1.0.0/16'
    subnetPrefix: '10.1.1.0/24'
    location: location
  }
}

module spoke2 'modules/spoke.bicep' = {
  name: 'spoke2Deploy'
  scope: rg
  params: {
    vnetName: 'vnet-spoke-data'
    addressPrefix: '10.2.0.0/16'
    subnetPrefix: '10.2.1.0/24'
    location: location
  }
}
module peStorage 'modules/privateendpoint-storage.bicep' = {
  name: 'peStorageDeploy'
  scope: rg
  params: {
    peName: 'pe-storage'
    subnetId: spoke1.outputs.subnetId
    storageAccountId: storage.outputs.storageId
    location: location
  }
}
