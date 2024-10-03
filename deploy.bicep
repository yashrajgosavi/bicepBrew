// Define the location for the resources
param location string = resourceGroup().location

// Define the prefix for resource names
param prefix string = resourceGroup().name

// Load JSON content from a separate file
var blobStorageParams = loadJsonContent('./parameters/BlobStorage-param/BlobStorage.json')

// Module to deploy Blob Storage resources
module storage './resources/BlobStorage/BlobStorage.bicep' = {
  name: 'storageModule'
  params: {
    prefix: prefix
    storageSuffix: blobStorageParams.storageSuffix
    storageSKU: blobStorageParams.storageSKU
    location: location
  }
}

// Output the storage endpoint
output storageEndpoint object = storage.outputs.storageEndpoint
