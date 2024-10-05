param location string

module acrResource '../../resources/acr/acr.bicep' = {
  name: 'brewacr'
  params:{
    acrName:'brewacr'
    acrSku: 'Basic'
    location: location
}
}
