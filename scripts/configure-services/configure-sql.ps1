
$webAppIps=$(az webapp show -g $rg -n $webAppName --query possibleOutboundIpAddresses -o tsv).Split(',')
$webJobIps=$(az webapp show -g $rg -n $webJobAppName --query possibleOutboundIpAddresses -o tsv).Split(',')

$appServiceIps = $webAppIps + $webJobIps

# TODO - use vnet integration instead   
foreach ($appServiceIp in $appServiceIps) {
    echo "Adding firewall rule for app service IP $appServiceIp"
    az sql server firewall-rule create `
    -g $rg -s $sqlServerName -n "appservice-$appServiceIp" `
    --start-ip-address $appServiceIp --end-ip-address $appServiceIp
}