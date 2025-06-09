$rgName = "arm-intro-07-web";
$loc = 'North Europe';

$id = "30699714692" # i need to find a method that gets a unique str from rg id
$storageAccountName = "stor$($id)";
$storageContainerName = "stor-container-$($id)"

$templatePath = "07-modularization/07-tut3-web.json";
$uploadedBlobName = "demo-web.json"

New-AzResourceGroup -Name $rgName -Location $loc -Force -Verbose;

New-AzStorageAccount `
	-ResourceGroupName $rgName `
	-Name $storageAccountName `
	-Location $loc `
	-SkuName "Standard_LRS" `
	-Kind "StorageV2" `
	-Verbose;

Set-AzStorageAccount -ResourceGroupName $rgName -Name $storageAccountName -AllowBlobPublicAccess $true;

New-AzRmStorageContainer `
	-ResourceGroupName $rgName `
	-StorageAccountName $storageAccountName `
	-Name $storageContainerName;

# get storage acct access key
$storAccKey = (Get-AzStorageAccountKey -ResourceGroupName $rgName -Name $storageAccountName)[0].Value;
$ctx = New-AzStorageContext `
	-StorageAccountName $storageAccountName `
	-StorageAccountKey $storAccKey;

# upload web arm template to storage container
Set-AzStorageBlobContent `
	-Context $ctx `
	-Container $storageContainerName `
	-File $templatePath `
	-Blob $uploadedBlobName;

# 1) dynamically set templateLink.uri in the arm file
# 1.2) get SAS token
$sasToken = New-AzStorageBlobSASToken -Container $storageContainerName -Blob $uploadedBlobName -Permission "rwd" -Context $ctx

# https://<storageAccountName>.blob.core.windows.net/<containerName>/<blobName>?<sasToken>
$blobUrl = "$($ctx.BlobEndPoint)$storageContainerName/$uploadedBlobName?$sasToken"