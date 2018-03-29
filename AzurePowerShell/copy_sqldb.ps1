<#
 .NOTES
    SQL Database コピー スクリプト

    .\copy_sqldb.ps1 `
        -SubscriptionName ec1513079@gmail.com `
        -ResourceGroupName AspNetVstsSample `
        -SqlServerName aspnetvstssample-sql-srv `
        -DatabaseName sampledb
#>

Param(
    [string] [Parameter(Mandatory = $true)] $SubscriptionName,
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $SqlServerName,
    [string] [Parameter(Mandatory = $true)] $DatabaseName,
    [string] $CopiedDBName = "${DatabaseName}_slot",
    [string] $OriginDBName = "${DatabaseName}_orig",
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
echo "<-- CopiedDBName -->" $CopiedDBName
echo "<-- OriginDBName -->" $OriginDBName
echo "<-- Silent -->" ([bool]$Silent)

# 1. スロット接続用の SQL Database を作成
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("データベースをコピー : $DatabaseName ($SqlServerName) -> $CopiedDBName ($SqlServerName)")
[Console]::WriteLine("=========================================================================")
New-AzureRmSqlDatabaseCopy `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $SqlServerName `
    -DatabaseName $DatabaseName `
    -CopyResourceGroupName $ResourceGroupName `
    -CopyServerName $SqlServerName `
    -CopyDatabaseName $CopiedDBName `
    -Confirm:(!$Silent)

# 2. 切り戻し用の SQL Database を作成
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("データベースをコピー : $DatabaseName ($SqlServerName) -> $OriginDBName ($SqlServerName)")
[Console]::WriteLine("=========================================================================")
New-AzureRmSqlDatabaseCopy `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $SqlServerName `
    -DatabaseName $DatabaseName `
    -CopyResourceGroupName $ResourceGroupName `
    -CopyServerName $SqlServerName `
    -CopyDatabaseName $OriginDBName `
    -Confirm:(!$Silent)