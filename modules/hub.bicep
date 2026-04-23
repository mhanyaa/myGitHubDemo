param vnetName string
param location string = resourceGroup().location

resource hub 'Microsoft.Network/virtualNetworks@2024-10-01' = {
  name: vnetName
  location: location
  scope: rg
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'shared-services'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}


output privateEndpointSubnetId string = hub.properties.subnets[1].id
