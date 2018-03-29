<#
 .NOTES
    デプロイメントスロット作成スクリプト

    .\create_webapps_slot.ps1 `
        -SubscriptionName ec1513079@gmail.com `
        -ResourceGroupName AspNetVstsSample `
        -WebAppName aspnetvstssample-web `
        -DatabaseName sampledb
#>

Param(
    [string] [Parameter(Mandatory = $true)] $SubscriptionName,
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $WebAppName,
    [string] [Parameter(Mandatory = $true)] $DatabaseName,
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
echo "<-- AppNames -->" $WebAppName
echo "<-- DatabaseName -->" $DatabaseName
echo "<-- SlotName -->" $SlotName
echo "<-- Silent -->" ([bool]$Silent)

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("デプロイスロットの作成 : $WebAppName-$SlotName ($ResourceGroupName)")
[Console]::WriteLine("=========================================================================")
New-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("ConnectionString 設定 : $WebAppName-$SlotName ($ResourceGroupName)")
[Console]::WriteLine("=========================================================================")
$Resource = Invoke-AzureRmResourceAction -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/slots/config" `
    -ResourceName "${WebAppName}/${SlotName}/connectionstrings" -Action list -ApiVersion 2016-08-01 -Force:($Silent)
if ($Resource.properties.DefaultConnection) {
    $Resource.properties.DefaultConnection.value = $Resource.properties.DefaultConnection.value -replace "${DatabaseName}", "${DatabaseName}_${SlotName}"
}
New-AzureRmResource -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/slots/config" `
    -ResourceName "${WebAppName}/${SlotName}/connectionstrings" -ApiVersion 2016-08-01 -Propertie $Resource.properties -Force:($Silent)