param containerAppName string
param location string
param containerAppEnvId string
param ingress object
param containers array
param scale object
@description('Name of the ACR secret')
param acrSecretName string

@description('Name of the Azure Container Registry')
param acrName string

@description('Resource group of the Azure Container Registry')
param acrResourceGroup string

resource containerApp 'Microsoft.App/containerApps@2023-11-02-preview' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: containerAppEnvId
    configuration: {
      ingress: ingress
      secrets: [
        {
          name: acrSecretName
          value: listCredentials(
            resourceId(
              subscription().subscriptionId,
              acrResourceGroup,
              'Microsoft.ContainerRegistry/registries',
              acrName
            ),
            '2019-05-01'
          ).passwords[0].value
        }
      ]
      registries: [
        {
          server: '${acrName}.azurecr.io'
          username: listCredentials(
            resourceId(
              subscription().subscriptionId,
              acrResourceGroup,
              'Microsoft.ContainerRegistry/registries',
              acrName
            ),
            '2019-05-01'
          ).username
          passwordSecretRef: acrSecretName
        }
      ]
    }
    template: {
      containers: containers
      scale: scale
    }
  }
}

output containerAppFQDN string = containerApp.properties.configuration.ingress.fqdn
