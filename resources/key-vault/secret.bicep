param vaultName string
param secretName string
@secure()
param secretValue string

resource secret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${vaultName}/${secretName}'
  properties: {
    value: secretValue
  }
}
