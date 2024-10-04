param location string

module brewstore '../../resources/BlobStorage/BlobStorage.bicep' = {
  name: 'brewstore'
  params: {
    uniqueStorageName: 'brewstore${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_LRS'
    location: location
  }
}
