
echo "Creating Virtual Network: $vnetName"

az network vnet create -g $rg -l $location `
 -n $vnetName --address-prefix "10.10.0.0/16"

az network vnet subnet create -g $rg `
 --vnet-name $vnetName -n $vnetSubnetName --address-prefix "10.10.1.0/24"