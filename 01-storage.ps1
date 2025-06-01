$rg = "arm-introduction-01";
New-AzResourceGroup -Name $rg -Location "northeurope" -Force;

New-AzResourceGroupDeployment `
    -Name "new-storage" `
    -ResourceGroupName $rg `
    -TemplateFile "01-storage.json" `
    -storageName "armtutorialstorage01" `
    -storageSKU "Standard_LRS"
