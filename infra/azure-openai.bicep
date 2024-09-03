param accounts_devops_demo_yt_summarizer_name string
param location string = resourceGroup().location

resource accounts_devops_demo_yt_summarizer_name_resource 'Microsoft.CognitiveServices/accounts@2024-04-01-preview' = {
  name: accounts_devops_demo_yt_summarizer_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    customSubDomainName: accounts_devops_demo_yt_summarizer_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource accounts_devops_demo_yt_summarizer_name_Default 'Microsoft.CognitiveServices/accounts/defenderForAISettings@2024-04-01-preview' = {
  parent: accounts_devops_demo_yt_summarizer_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource accounts_devops_demo_yt_summarizer_name_GPT_4o_mini 'Microsoft.CognitiveServices/accounts/deployments@2024-04-01-preview' = {
  parent: accounts_devops_demo_yt_summarizer_name_resource
  name: 'GPT-4o-mini'
  sku: {
    name: 'GlobalStandard'
    capacity: 373
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o-mini'
      version: '2024-07-18'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 373
  }
}

output azureOpenAIDeploymentEndpoint string = accounts_devops_demo_yt_summarizer_name_resource.properties.endpoint
output azureOpenAIResourceId string = accounts_devops_demo_yt_summarizer_name_resource.id
