targetScope = 'subscription'
param location string = 'swedencentral'
param name string = 'SummarizationApp'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: name
  location: location
}

output resourceGroupName string = resourceGroup.name
