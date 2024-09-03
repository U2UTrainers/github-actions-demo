param azureOpenAIDeploymentName string
param webAppName string

module azureOpenAI 'azure-openai.bicep' = {
  name: azureOpenAIDeploymentName
  params: {
    accounts_devops_demo_yt_summarizer_name: azureOpenAIDeploymentName
  }
}

module webApp 'web-app.bicep' = {
  name: 'app'
  // dependsOn: [
  //   azureOpenAI
  // ]
  params: {
    azureOpenAIDeploymentEndpoint: azureOpenAI.outputs.azureOpenAIDeploymentEndpoint
    webAppName: webAppName
  }
}
