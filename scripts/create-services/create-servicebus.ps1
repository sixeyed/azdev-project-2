
echo "Creating Service Bus: $serviceBusName"

az servicebus namespace create -g $rg -l $location `
 -n $serviceBusName `
 --sku Basic

az servicebus queue create -g $rg `
--namespace-name $serviceBusName `
--name 'events.todo.newitem'

az servicebus queue create -g $rg `
--namespace-name $serviceBusName `
--name 'events.todo.itemsaved'