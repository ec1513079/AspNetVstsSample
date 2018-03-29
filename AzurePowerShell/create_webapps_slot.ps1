<#
 .NOTES
    �f�v���C�����g�X���b�g�쐬�X�N���v�g

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

# 0. Azure Powershell �ւ̃��O�C�� �y�� �T�u�X�N���v�V�����ݒ�
try {
    Select-AzureRmSubscription -SubscriptionName $SubscriptionName
} catch {
    Login-AzureRmAccount -SubscriptionName $SubscriptionName
}

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("���̓p�����[�^")
[Console]::WriteLine("=========================================================================")
echo "<-- SubscriptionName -->" $SubscriptionName
echo "<-- ResourceGroupName -->" $ResourceGroupName
echo "<-- AppNames -->" $WebAppName
echo "<-- DatabaseName -->" $DatabaseName
echo "<-- SlotName -->" $SlotName
echo "<-- Silent -->" ([bool]$Silent)

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("�f�v���C�X���b�g�̍쐬 : $WebAppName-$SlotName ($ResourceGroupName)")
[Console]::WriteLine("=========================================================================")
New-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName

[Console]::WriteLine("=========================================================================")
[Console]::WriteLine("ConnectionString �ݒ� : $WebAppName-$SlotName ($ResourceGroupName)")
[Console]::WriteLine("=========================================================================")
$Resource = Invoke-AzureRmResourceAction -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/slots/config" `
    -ResourceName "${WebAppName}/${SlotName}/connectionstrings" -Action list -ApiVersion 2016-08-01 -Force:($Silent)
if ($Resource.properties.DefaultConnection) {
    $Resource.properties.DefaultConnection.value = $Resource.properties.DefaultConnection.value -replace "${DatabaseName}", "${DatabaseName}_${SlotName}"
}
New-AzureRmResource -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/slots/config" `
    -ResourceName "${WebAppName}/${SlotName}/connectionstrings" -ApiVersion 2016-08-01 -Propertie $Resource.properties -Force:($Silent)