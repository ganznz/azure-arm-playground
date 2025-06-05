$rgName = "arm-intro-06";

New-AzResourceGroupDeployment `
	-Name "arm-intro-06.3-deployment" `
	-ResourceGroupName $rgName `
	-TemplateFile "06-conditional-deployments/06-tut3.json" `
	-Force `
	-Verbose