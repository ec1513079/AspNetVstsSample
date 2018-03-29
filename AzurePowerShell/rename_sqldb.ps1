<#
 .NOTES
    SQL Database リネーム スクリプト

    .\rename_sqldb.ps1 `
        -SubscriptionName ec1513079@gmail.com `
        -ResourceGroupName AspNetVstsSample `
        -SqlServerName aspnetvstssample-sql-srv `
        -DatabaseName sampledb `
        -NewName sampledb_rename
#>

Param(
    [string] [Parameter(Mandatory = $true)] $SubscriptionName,
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $SqlServerName,
    [string] [Parameter(Mandatory = $true)] $DatabaseName,
    [string] [Parameter(Mandatory = $true)] $NewName,
    [switch] $Silent
)

$ErrorActionPreference = "Stop"

# 0. Azure Powershell へのログイン 及び サブスクリプション設定
try {
    Select-AzureRmSubscription -SubscriptionName $SubscriptionName
} catch {
    Login-AzureRmAccount -SubscriptionName $SubscriptionName
}

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("入力パラメータ")
[Console]::WriteLine("=========================================================================")
echo "<-- SubscriptionName -->" $SubscriptionName
echo "<-- ResourceGroupName -->" $ResourceGroupName
echo "<-- SqlServerName -->" $SqlServerName
echo "<-- DatabaseName -->" $DatabaseName
echo "<-- NewName -->" $NewName
echo "<-- Silent -->" ([bool]$Silent)

# 1. SQL Database をリネーム
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("データベースをリネーム : $DatabaseName ($SqlServerName) -> $NewName ($SqlServerName)")
[Console]::WriteLine("=========================================================================")
Set-AzureRmSqlDatabase `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $SqlServerName `
    -DatabaseName $DatabaseName `
    -NewName $NewName `
    -Confirm:(!$Silent)