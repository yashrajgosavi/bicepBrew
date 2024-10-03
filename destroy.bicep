var blobStorageParams = loadJsonContent('./parameters/BlobStorage-param/BlobStorage.json')

resource storage 'Microsoft.Storage/storageAccounts@2023-04-01' existing = {
  name: '${blobStorageParams[0].storagePrefix}${uniqueString(resourceGroup().id)}'
}

output blobEndpoint string = storage.properties.primaryEndpoints.blob
