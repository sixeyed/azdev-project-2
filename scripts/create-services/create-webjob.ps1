
echo "Creating webjob App Service Plan: $webJobAppPlanName"

az appservice plan create `
  -l $location -g $rg -n $webJobAppPlanName --sku B1 --number-of-workers 1

echo "Creating webjob: $webJobAppName"

az webapp create `
-g $rg --plan $webJobAppPlanName --runtime dotnet:6 -n $webJobAppName

az webapp config set --always-on true `
 -g $rg -n $webJobAppName  

echo "Configuring webjob deployment from: $webJobDeployPath"

az webapp deployment source config-zip `
 -g $rg -n $webJobAppName `
 --src $webJobDeployPath

echo "Configuring Managed Identity for webjob: $webJobAppName"

$managedIdentity=$(az webapp identity assign -g $rg -n $webJobAppName) | ConvertFrom-Json
az keyvault set-policy --secret-permissions get list --object-id $managedIdentity.principalId -n $keyVaultName
