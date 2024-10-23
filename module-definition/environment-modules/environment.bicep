module environment '../../resources/environment/environment.bicep' = {
  name: 'containerAppEnv'
  params: {
    containerAppEnvName: 'env-mtaf-dev'
    customerId: 'logAnalytics.outputs.customerId'
    primarySharedKey: 'logAnalytics.outputs.primarySharedKey'
  }
}
