@description('Location for the resources')
param location string = resourceGroup().location
param appName string = 'brewBicep'
param objectId string
param tenantId string = subscription().tenantId

@maxLength(24)
param vaultName string = '${'kv-'}${appName}-${substring(uniqueString(resourceGroup().id), 0, 23 - (length(appName) + 3))}' // must be globally unique
var keyVaultParams = loadJsonContent('./parameters/key-vault-param/brewkv.json')

module keyVault './resources/key-vault/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    vaultName: vaultName
    location: location
    tenantId: subscription().tenantId
    sku: keyVaultParams.sku
    accessPolicies: keyVaultParams.accessPolicies
    enabledForDeployment: keyVaultParams.enabledForDeployment
    enabledForDiskEncryption: keyVaultParams.enabledForDiskEncryption
    enabledForTemplateDeployment: keyVaultParams.enabledForTemplateDeployment
    softDeleteRetentionInDays: keyVaultParams.softDeleteRetentionInDays
    enableRbacAuthorization: keyVaultParams.enableRbacAuthorization
    networkAcls: keyVaultParams.networkAcls
  }
}

module acrResource './resources/acr/acr.bicep' = {
  name: 'acrResource'
  params: {
    keyVaultName: keyVault.name
    acrName: 'brewacr'
    acrSku: 'Basic'
    location: location
  }
}
