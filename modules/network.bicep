param vnetName string

resource vnet 'Microsoft.Network/virtualNetworks@2023-08-01' = {
  name: vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [ '10.0.0.0/16' ]
      {
        sunbnets: [
          {
            name: 'app-subnet'
            properties: {
              addressPrefix: '10.0.1.0/24'
            }
        ]
      }
    }
  }
}
