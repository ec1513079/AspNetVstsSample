<#
 .NOTES
    SQL Database 削除 スクリプト

    .\delete_sqldb.ps1 `
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

# 1. スロット接続用の SQL Database を削除
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("データベースを削除 : $CopiedDBName ($SqlServerName)")
[Console]::WriteLine("=========================================================================")
Remove-AzureRmSqlDatabase `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $SqlServerName `
    -DatabaseName $CopiedDBName `
    -Confirm:(!$Silent)

# 2. 切り戻し用の SQL Database を削除
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("データベースを削除 : $OriginDBName ($SqlServerName)")
[Console]::WriteLine("=========================================================================")
Remove-AzureRmSqlDatabase `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $SqlServerName `
    -DatabaseName $OriginDBName `
    -Confirm:(!$Silent)