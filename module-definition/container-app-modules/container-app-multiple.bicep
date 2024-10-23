param location string = resourceGroup().location

var influxDbParams = loadJsonContent('../../parameters/container-param/mtaf-influxdb.json')
var containerApps = [influxDbParams]
param environment object

module containerAppModule '../../resources/container-app/container-app.bicep' = [
  for app in containerApps: {
    name: 'containerAppModule-${app.containerAppName}'
    params: {
      acrSecretName: app.acrSecretName
      containerAppEnvId: environment.outputs.containerAppEnvironmentId
      containerAppName: app.containerAppName
      ingress: app.ingress
      location: location
      containers: app.containers
      scale: app.scale
      acrName: app.acrName
      acrResourceGroup: app.acrResourceGroup
    }
  }
]
