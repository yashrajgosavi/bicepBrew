// define the module that u dont wanna destroy and dont define the module that u wanna destroy

param location string = resourceGroup().location

module brewstore './resources/BlobStorage/BlobStorage.bicep' = {
  name: 'brewstore'
  params: {
    uniqueStorageName: 'brewstore${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_GRS'
    location: location
  }
}
