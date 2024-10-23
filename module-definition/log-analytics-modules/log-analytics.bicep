module logAnalytics '../../resources/log-analytics/log-analytics.bicep' = {
  name: 'logAnalyticsModule'
  params: {
    logAnalyticsName: 'log-mtaf-dev'
    logAnalyticsSKU: 'PerGB2018'
  }
}
