param location string = resourceGroup().location

var influxDbParams = loadJsonContent('../../parameters/container-param/mtaf-influxdb.json')

module containerAppModule '../../resources/container-app/container-app.bicep' = {
  name: 'containerAppModule-${influxDbParams.containerAppName}'
  params: {
    acrSecretName: influxDbParams.acrSecretName
    containerAppEnvId: 'environment.outputs.containerAppEnvironmentId'
    containerAppName: influxDbParams.containerAppName
    ingress: influxDbParams.ingress
    location: location
    containers: influxDbParams.containers
    scale: influxDbParams.scale
    acrName: influxDbParams.acrName
    acrResourceGroup: influxDbParams.acrResourceGroup
  }
}
