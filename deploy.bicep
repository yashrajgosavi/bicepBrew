// Define the location for the resources
param location string = resourceGroup().location

// Load JSON content from a separate file
var blobStorageParamsArray = loadJsonContent('./parameters/BlobStorage-param/BlobStorage.json')

// Module to deploy Blob Storage resources
module storageModule './resources/BlobStorage/BlobStorage.bicep' = [
  for singleStorage in blobStorageParamsArray: {
    name: 'storageModule-${singleStorage.storagePrefix}'
    params: {
      uniqueStorageName: '${singleStorage.storagePrefix}${uniqueString(resourceGroup().id)}'
      storageSKU: singleStorage.storageSKU
      location: location
    }
  }
]
