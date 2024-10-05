param location string
param vaultName string
@description('The object ID of the service principal to grant key vault access')
param userAccessPolicies array

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: userAccessPolicies
    enabledForDeployment: true // VMs can retrieve certificates
    enabledForTemplateDeployment: true // ARM can retrieve values
  }
}
