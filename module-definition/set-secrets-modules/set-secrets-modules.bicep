module setACRAdminUsername '../../resources/key-vault/set-secrets.bicep' = {
  name: 'setACRAdminUsername'
  params: {
    keyVaultName: keyVaultName
    secretName: 'ACRAdminUsername'
    secretValue: acrResource.listCredentials().username
  }
}

module setACRAdminPassword '../../resources/key-vault/set-secrets.bicep' = {
  name: 'setACRAdminPassword'
  params: {
    keyVaultName: keyVaultName
    secretName: 'ACRAdminPassword'
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
