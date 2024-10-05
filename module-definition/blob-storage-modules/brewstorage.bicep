param location string

module strorageModule '../../resources/blob-storage/blob-storage.bicep' = {
  name: 'strorageModule'
  params: {
    uniqueStorageName: 'brewstorage${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_LRS'
    location: location
  }
}
