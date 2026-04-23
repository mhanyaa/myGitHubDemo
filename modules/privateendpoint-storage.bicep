param peName string
param location string = resourceGroup().location
param subnetId string
param storageAccountId string

resource pe 'Microsoft.Network/privateEndpoints@2023-09-01' = {
  name: peName
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${peName}-conn'
        properties: {
          privateLinkServiceId: storageAccountId
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

output privateEndpointId string = pe.id
