param webAppName string
param location string = resourceGroup().location
param azureOpenAIDeploymentEndpoint string

@description('This is the built-in Cognitive Services OpenAI User')
resource azureOpenAIUserRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'AppServicePlan-${webAppName}'
  location: location
  sku: {
    name: 'F1'
    tier: 'Basic'
  }
  kind: 'app'
}

resource appService 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        // Add other app settings as needed
        {
          name: 'AzureOpenAI:ChatCompletionEndpoint'
          value: azureOpenAIDeploymentEndpoint
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned' 
  }
}

// Role assignment to grant App Service access to the Azure OpenAI resource
resource openAIroleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(appService.id, 'Cognitive Services OpenAI User')
  properties: {
    roleDefinitionId: azureOpenAIUserRoleDefinition.id
    principalId: appService.identity.principalId
  }
}
