# Welcome to bicepBrew!

## Introduction

bicepBrew is a project designed to help you develop Azure Bicep skills through practical exercises and recipes. This guide walks you through the essential steps to set up a Bicep development environment and configure Continuous Integration/Continuous Deployment (CI/CD) using GitHub Actions.

## Prerequisites

Before starting, ensure you have:

- An Azure account with an active subscription
- GitHub account
- Basic knowledge of Azure CLI and Bicep syntax

## Installation and Setup

### Step 1: Install Azure CLI

First, install the Azure CLI following the official Microsoft documentation [1].

### Step 2: Configure CI/CD with GitHub Actions

To set up CI/CD for Azure deployments:

1. Create a `.github/workflows/workflow.yml` file in your repository.
2. Add the following YAML content to the file:

```yaml
name: Deploy Bicep file
on:
  workflow_dispatch:
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
```

### Step 3: Set Up Azure CLI Login

Run the following command to log in to your Azure account:

```
az login
```

### Step 4: Create Resource Group

Create a resource group for your Bicep projects:

```
az group create -n bicepBrew -l centralindia
```

### Step 5: Generate Deployment Credentials

Generate deployment credentials for CI/CD:

```
az ad sp create-for-rbac --name {app-name} --role contributor --scopes /subscriptions/{subscription-id}/resourceGroups/exampleRG --json-auth
```

Replace `{app-name}` with your application name and `{subscription-id}` with your subscription ID.

### Step 6: Create a bicep template for deployment

The current setup differs slightly from the standard approach. Instead of defining parameters inline, we're using a custom method:

1. Create a `parameters` folder in your project structure.
2. Define parameter files within this folder (e.g., `blob-storage-param/blob-storage.json`).
3. Load parameters in your Bicep template using the `loadJsonContent()` function:

```bicep
var blob-storageParams = loadJsonContent('./parameters/blob-storage-param/blob-storage.json')
```

4. Deploy the Bicep template using the GitHub Actions workflow.

### Step 7: Create a bicep template for resource management

There are two main approaches for managing resources with Bicep:

1. **Incremental Mode**: This is the default mode and is suitable for most scenarios.

   ```bicep
   targetScope = 'resourceGroup'

   param mode string = 'Incremental'

   resource exampleResource 'Microsoft.Web/sites@2021-02-01' existing = {
     name: 'exampleSite'
     location: 'East US'
     sku: {
       name: 'Free'
     }
   }

   output exampleOutput string = mode
   ```

2. **Complete Mode**: This mode allows for more aggressive resource management, including deletion of resources not specified in the template.

   ```bicep
   targetScope = 'resourceGroup'

   param mode string = 'Complete'

   resource exampleResource 'Microsoft.Web/sites@2021-02-01' existing = {
     name: 'exampleSite'
     location: 'East US'
     sku: {
       name: 'Free'
     }
   }

   output exampleOutput string = mode
   ```

Key points to consider:

- **Incremental Mode**: This is the default mode and is suitable for most scenarios. It will update existing resources but won't delete resources not specified in the template.

- **Complete Mode**: This mode allows for more aggressive resource management. It will delete resources not specified in the template. Be cautious when using this mode as it can lead to unintended deletions.

**Note:** If u wanna delete a particular resource just don't define it in the script

- Only root-level templates support Complete mode. Linked or nested templates must use Incremental mode.

- Subscription level deployments don't support Complete mode.


**Note:** The module-definition will contain all the resources that u wanna deploy and just copy them and paste it in the deploy.bicep if u wanna deploy those resources

**Note:** Define the module in the destroy.bicep that u dont wanna destroy and dont define the module that u wanna destroy
