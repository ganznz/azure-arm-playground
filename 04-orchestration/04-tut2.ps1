$rgName = "arm-intro-04-pshell"
New-AzResourceGroup -Name $rgName -Location 'New Zealand North' -Force;

New-AzResourceGroupDeployment `
	-Name "arm-intro-04-deploy" `
	-ResourceGroupName $rgName `
	-TemplateFile "./04-orchestration/04-tut2.json" `
	-TemplateParameterFile "./04-orchestration/04-tut2.parameters.json" `
	-Verbose
	
