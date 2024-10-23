param acrName string
param location string
param acrSku string
param keyVaultName string

resource acrResource 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true
  }
}

module setACRAdminPassword '../../resources/key-vault/set-secrets.bicep' = {
  name: 'setACRAdminPassword'
  params: {
    keyVaultName: keyVaultName
    secretName: 'ACRAdminPassword'
    secretValue: acrResource.listCredentials().username
  }
}

module setACRAdminUsername '../../resources/key-vault/set-secrets.bicep' = {
  name: 'setACRAdminUsername'
  params: {
    keyVaultName: keyVaultName
    secretName: 'ACRAdminUsername'
    secretValue: acrResource.listCredentials().passwords[0].value
  }
}

module setACRLoginServer '../../resources/key-vault/set-secrets.bicep' = {
  name: 'setACRLoginServer'
  params: {
    keyVaultName: keyVaultName
    secretName: 'ACRLoginServer'
    secretValue: acrResource.properties.loginServer
  }
}
