$rgName = "arm-intro-05-pshell";

New-AzResourceGroup -Name $rgName -Location 'East US' -Force

New-AzResourceGroupDeployment `
	-Name "arm-intro-05-3-deploy" `
	-ResourceGroupName $rgName `
	-TemplateFile "05-copy-loops/05-tut3.json" `
	-containerCount 3 `
	-Verbose