
echo "Configuring KeyVault app settings for:  $webAppName"

az webapp config appsettings set `
  -g $rg -n $webAppName `
  --settings KeyVault__Enabled='True' KeyVault__Name="$keyVaultName"

echo "Configuring KeyVault app settings for:  $webJobAppName"

az webapp config appsettings set `
  -g $rg -n $webJobAppName `
  --settings KeyVault__Enabled='True' KeyVault__Name="$keyVaultName"

echo "Storing connection string for SQL DB: $sqlServerName in KeyVault: $keyVaultName"

$connectionStringTemplate=$(az sql db show-connection-string --server $sqlServerName --client ado.net -o tsv)
$connectionString=$connectionStringTemplate.Replace('<databasename>', $sqlDatabaseName).Replace('<username>', $sqlUserName).Replace('<password>', $sqlPassword)
az keyvault secret set --name 'ConnectionStrings--ToDoDb' --value $connectionString --vault-name $keyVaultName

echo "Storing connection string for ServiceBus: $serviceBusName in KeyVault: $keyVaultName"

$serviceBusConnectionString=$(az servicebus namespace authorization-rule keys list -n RootManageSharedAccessKey -g $rg  --query primaryConnectionString -o tsv --namespace-name $serviceBusName)
az keyvault secret set --name 'ConnectionStrings--ServiceBus' --value $serviceBusConnectionString --vault-name $keyVaultName

echo "Storing connection string for Storage Account: $storageAccountName in KeyVault: $keyVaultName"

$tableStorageConnectionString=$(az storage account show-connection-string -g $rg -n $storageAccountName --query connectionString -o tsv)
az keyvault secret set --name 'Serilog--WriteTo--0--Args--connectionString' --value $tableStorageConnectionString --vault-name $keyVaultName
