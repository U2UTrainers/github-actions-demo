param azureOpenAIServiceName string
param location string
@allowed(['Production', 'Development'])
param environmentType string

resource azureOpenAIResource 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: '${azureOpenAIServiceName}-${environmentType}'
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    customSubDomainName: '${azureOpenAIServiceName}-${environmentType}'
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource azureOpenAIServiceName_GPT_4o_mini 'Microsoft.CognitiveServices/accounts/deployments@2024-10-01' = {
  parent: azureOpenAIResource
  name: 'GPT-4o-mini'
  sku: {
    name: 'GlobalStandard'
    capacity: 100
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o-mini'
      version: '2024-07-18'
    }
    versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    currentCapacity: 100
  }
}

output azureOpenAIDeploymentEndpoint string = azureOpenAIResource.properties.endpoint
output azureOpenAIResourceId string = azureOpenAIResource.id
