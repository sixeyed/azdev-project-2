# azdev-project-2-

## Pre-reqs

Create a file `scripts/secrets.ps1` with the confidential data items:

```
$env:LAB_PASSWORD='<password-for-sql-server>'

$env:GH_TOKEN='<your-github-access-token'
```

## Run locally

You'll need SQL Server, Service Bus & Table Storage already set up in Azure. 

Get the connection strings for those services, then run the backend message handler:

```
cd projects/distributed/src/save-handler

dotnet run `
 --ConnectionStrings:ToDoDb='<sqlserver-connection-string>' `
 --ConnectionStrings:ServiceBus='<servicebus-connection-string>' `
 --Serilog:WriteTo:0:Args:connectionString='<tablestorage-connection-string>'
```

You'll see a couple of log entries in the terminal. Then check your Table Storage and you should see a log saying the handler has subscribed to the queue.

Next open a new terminal to run the website:

```
cd projects/distributed/src/web

dotnet run `
 --ConnectionStrings:ToDoDb='<sqlserver-connection-string>' `
 --ConnectionStrings:ServiceBus='<servicebus-connection-string>' `
 --Serilog:WriteTo:0:Args:connectionString='<tablestorage-connection-string>'
```

Browse to http://localhost:5000.

## Test environment

Deploy with a serverless SQL database with 1 CPU, and a single App Service worker:

```
cd scripts

./deploy-test.ps1
```

> Deployment will be in the RG called `rg-proj1todotest`


## Production environment

Deploy with a 4-CPU SQL database and 3 App Service workers:

```
./deploy-prod.ps1
```

> Deployment will be in the RG called `rg-proj1todoprod`

## Teardown

```
./delete-test.ps1

./delete-prod.ps1
```
