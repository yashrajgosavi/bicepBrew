// log-analytics.bicep

param logAnalyticsName string
param logAnalyticsSKU string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName
  location: resourceGroup().location
  properties: any({
    retentionInDays: 30
    sku: {
      name: logAnalyticsSKU
    }
  })
}

resource logAnalyticsKeys 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: logAnalyticsName
}

output customerId string = logAnalytics.properties.customerId
output primarySharedKey string = logAnalyticsKeys.listKeys().primarySharedKey
