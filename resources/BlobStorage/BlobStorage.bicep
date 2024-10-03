@minLength(3)
@maxLength(11)
param storageSuffix string

param prefix string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string

// Use the location from the resource group
param location string = resourceGroup().location

// Generate a unique storage name using prefix and suffix
var uniqueName = '${prefix}-${storageSuffix}'

// Define the Storage Account resource
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

// Output the primary endpoint of the storage account
output storageEndpoint object = stg.properties.primaryEndpoints
