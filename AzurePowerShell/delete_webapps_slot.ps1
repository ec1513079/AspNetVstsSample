<#
 .NOTES
    デプロイメントスロット削除スクリプト

    .\delete_webapps_slot.ps1 `
        -SubscriptionName ec1513079@gmail.com `
        -ResourceGroupName AspNetVstsSample `
        -WebAppName aspnetvstssample-web
#>

Param(
    [string] [Parameter(Mandatory = $true)] $SubscriptionName,
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $WebAppName,
    [string] $SlotName = "slot",
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
echo "<-- WebAppName -->" $WebAppName
echo "<-- SlotName -->" $SlotName
echo "<-- Silent -->" ([bool]$Silent)

# 1. デプロイスロットの削除
[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("デプロイスロットの削除 : $WebAppName-$SlotName ($ResourceGroupName)")
[Console]::WriteLine("=========================================================================")
Remove-AzureRmWebAppSlot `
    -ResourceGroupName $ResourceGroupName `
    -Name $WebAppName `
    -Slot $SlotName `
    -Force:($Silent)