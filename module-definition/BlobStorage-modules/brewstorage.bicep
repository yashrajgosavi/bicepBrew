param location string

module brewstorage '../../resources/BlobStorage/BlobStorage.bicep' = {
  name: 'brewstorage'
  params: {
    uniqueStorageName: 'brewstorage${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_LRS'
    location: location
  }
}
