
echo "Creating webapp App Service Plan: $appPlanName"

az appservice plan create `
  -l $location -g $rg -n $appPlanName `
  --is-linux `
  --sku $appPlanSku `
  --number-of-workers $appPlanWorkerCount

echo "Creating web app: $webAppName"

az webapp create `
  -g $rg -n $webAppName `
  --plan $appPlanName `
  --runtime dotnetcore:6.0

echo "Configuring web app deployment from: $webAppGitBranch branch; $webAppGitUrl"

az webapp config appsettings set `
  -g $rg -n $webAppName `
  --settings PROJECT='src/web/ToDoList.csproj' DEPLOYMENT_BRANCH=$webAppGitBranch

az webapp deployment source config `
  -g $rg -n $webAppName `
  --branch $webAppGitBranch `
  --repo-url $webAppGitHubUrl `
  --git-token $webAppGitHubToken

echo "Configuring Managed Identity for web app: $webAppName"

$managedIdentity=$(az webapp identity assign -g $rg -n $webAppName) | ConvertFrom-Json
az keyvault set-policy --secret-permissions get list --object-id $managedIdentity.principalId -n $keyVaultName