param location string = resourceGroup().location

var blobStorageParamsArray = loadJsonContent('./parameters/BlobStorage-param/BlobStorage.json')

module storageModule './resources/BlobStorage/BlobStorage.bicep' = {
  name: 'storageModule'
  params: {
    uniqueStorageName: '${blobStorageParamsArray[0].storagePrefix}${uniqueString(resourceGroup().id)}'
    storageSKU: blobStorageParamsArray[0].storageSKU
    location: location
  }
}
