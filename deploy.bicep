param location string = resourceGroup().location

param objectId string

module keyVault './resources/key-vault/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    location: location
    vaultName: 'brewkv'
    userAccessPolicies: [
      {
        objectId: objectId
        tenantId: subscription().tenantId
        permissions: {
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          keys: [
            'all'
          ]
        }
      }
    ]
  }
}

module acrResource './resources/acr/acr.bicep' = {
  name: 'acrResource'
  params: {
    acrName: 'brewacr'
    acrSku: 'Basic'
    location: location
  }
}
