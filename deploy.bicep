@description('Location for the resources')
param location string = resourceGroup().location
param appName string = 'brewBicep'

param mainObjectId string
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
    tenantId: tenantId
    sku: keyVaultParams.sku
    accessPolicies: [
      {
        objectId: mainObjectId
        tenantId: tenantId
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
      {
        objectId: objectId
        tenantId: tenantId
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
  dependsOn: [
    keyVault
  ]
  params: {
    keyVaultName: vaultName
    acrName: 'brewacr'
    acrSku: 'Basic'
    location: location
  }
}
