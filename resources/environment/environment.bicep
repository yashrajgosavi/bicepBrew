// environment.bicep

param containerAppEnvName string
param customerId string
param primarySharedKey string

resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-08-01-preview' = {
  name: containerAppEnvName
  location: resourceGroup().location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: customerId
        sharedKey: primarySharedKey
      }
    }
  }
}

output containerAppEnvironmentId string = containerAppEnv.id
