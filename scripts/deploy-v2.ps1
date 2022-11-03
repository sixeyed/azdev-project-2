
. ./secrets.ps1
. ./00-set-variables.ps1

# core resources - sequential:
$scripts =$(Get-ChildItem ./create-core/*.ps1 | Sort $_.name)
foreach ($script in $scripts) {
    Invoke-Expression ". $($script.FullName)"
}

# services - parallel:
$scripts =$(Get-ChildItem ./create-services/*.ps1)
$jobs = @()
foreach ($script in $scripts) {
    echo "Starting create job for script: $($script.Name)"
    $jobs += Start-Job -FilePath $script.FullName
}
while ($jobs.HasMoreData -and $jobs.State -eq "Running") {
    Receive-Job -Job $jobs -ErrorAction Continue
}

# configuration - sequential:
$scripts =$(Get-ChildItem ./configure-services/*.ps1 | Sort $_.name)
foreach ($script in $scripts) {
    Invoke-Expression ". $($script.FullName)"
}