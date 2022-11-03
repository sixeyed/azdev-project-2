
echo "Creating Storage Account: $storageAccountName"

az storage account create `
  -l $location -g $rg -n $storageAccountName `
  --sku Standard_LRS

echo "Creating log storage table"

az storage table create `
  -n logs --account-name $storageAccountName