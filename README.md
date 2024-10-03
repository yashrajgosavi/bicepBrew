# Welcome to bicepBrew!

#### Brewing up Azure Bicep skills, one recipe at a time.

### Step 1: Install Azure CLI

First things first, we need to install the Azure CLI.
[Bicep Install](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)

### Step 2: CI/CD with GitHub Actions

To set up CI/CD with GitHub Actions for Azure deployments:

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
