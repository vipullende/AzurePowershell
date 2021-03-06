#######################################################################
#  This script is to get the vnet details from all azure subscription #
#######################################################################
#  Created by: Vipul Lende                                           #
######################################################################

$arrayData = @()
$subs = Get-AzSubscription
foreach ($sub in $subs) {
        Select-AzSubscription -subscription $sub.name


$VNETs = Get-AzVirtualNetwork



	foreach ($VNET in $VNETs) 
{
        #$VNET.Location
        $vNetName = $VNET.Name
        $vNetAdd = $VNET.AddressSpace.AddressPrefixes -join,','
     

        #$vNetAdd = ($VNET).AddressSpace.AddressPrefixes
        $vNetRG = $vnet.ResourceGroupName
        $vNetSubnet= ($VNET).Subnets.Name -join,','
		
        $Report = " " | Select "vNet Name", "vNet Location", "vNet Address", "vNet Resource Group Name", "vNet Subnet"
        $Report."vNet Name" = $vNetName
        $Report."vNet Location" = $VNET.Location
        $Report."vNet Address" = $vNetAdd 
        $Report."vNet Resource Group Name"  = $vNetRG
        $Report."vNet Subnet" = $vNetSubnet 

        $arraydata += $Report
	}


}
$arrayData | Export-Csv -NoTypeInformation .\Vnet_Info.csv 


