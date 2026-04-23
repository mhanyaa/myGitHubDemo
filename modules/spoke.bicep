param vnetName string
param addressPrefix string
param subnetPrefix string
param location string = resourceGroup().location

resource spoke 'Microsoft.Network/virtualNetworks@2024-10-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'workload-subnet'
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

output spokeVnetId string = spoke.id
