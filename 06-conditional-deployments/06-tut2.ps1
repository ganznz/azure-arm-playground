$rgName = "arm-intro-06";

New-AzResourceGroupDeployment `
	-Name "arm-intro-06.2-deployment" `
	-ResourceGroupName $rgName `
	-TemplateFile "06-conditional-deployments/06-tut2.json" `
	# -storageAccountName "armintro0602stor"`
	-Force `
	-Verbose