// Define the location for the resources
param location string = resourceGroup().location

module brewstorage './resources/BlobStorage/BlobStorage.bicep' = {
  name: 'brewstorage'
  params: {
    uniqueStorageName: 'brewstorage${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_LRS'
    location: location
  }
}

module brewstore './resources/BlobStorage/BlobStorage.bicep' = {
  name: 'brewstore'
  params: {
    uniqueStorageName: 'brewstore${uniqueString(resourceGroup().id)}'
    storageSKU: 'Standard_LRS'
    location: location
  }
}
