
echo "Creating Key Vault: $keyVaultName"

az keyvault create -g $rg -l $location `
 -n $keyVaultName