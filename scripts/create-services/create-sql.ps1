
echo "Creating SQL Server: $sqlServerName"

az sql server create `
  -l $location -g $rg -n $sqlServerName `
  -u $sqlUserName `
  -p $sqlPassword

echo "Creating SQL Database: $sqlDatabaseName"

az sql db create `
  -g $rg -n $sqlDatabaseName `
  -s $sqlServerName `
  --max-size $sqlDatabaseMaxSize  `
  --compute-model $sqlDatabaseComputeModel `
   -e $sqlDatabaseEdition `
   -c $sqlDatabaseCapacity `
   -f $sqlDatabaseFamily