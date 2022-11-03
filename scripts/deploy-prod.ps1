
$env:ENVIRONMENT_NAME='prod'
$env:APP_PLAN_SKU='S1'
$env:APP_PLAN_WORKER_COUNT='3'
$env:SQL_DB_COMPUTE_MODEL='Provisioned'
$env:SQL_DB_MAX_SIZE='32GB'
$env:SQL_DB_CAPACITY='4'

./deploy.ps1