# We are deploying the Bastion Host and linking it to the Bastion Subnet and public IP

#Set Variables
rg="bastion-rg"
img="Ubuntu2204"
loc="canadacentral"
PipName="bastion-pip"
# vnet="${RG}-vnet"
# subnet="${RG}-subnet"
# vm="${RG}-vm"
# nsg="${RG}-nsg"

echo "Creating resource group: $rg"
az group create --name $rg --location $loc

echo "Creating Vnet ${rg}-vnet with subnet ${rg}-subnet"
az network vnet create -g $rg -n ${rg}-vnet \
--address-prefix 10.10.0.0/16 \
--subnet-name ${rg}-subnet \
--subnet-prefixes 10.10.0.0/24 -l $loc

echo "Creating virtual machine: ${rg}-vm"
az vm create -g $rg -n ${rg}-vm \
--image $img \
--vnet-address-prefix 10.10.0.0/16 \
--admin-username azureuser \
--generate-ssh-keys \
--authentication-type ssh \
--public-ip-address "" \
--nsg-rule SSH \
--size Standard_B1s \
--nsg ${rg}-nsg

echo "Creating bastion public ip address $PipName" 
az network public-ip create -g $rg -n $PipName \
--sku Standard

# az network bastion create -g bastionrg -n bastionrg-bastion \
# --public-ip-address BastionPip \
# --vnet-name bastionrg-vNet \
# --location canadacentral

# to find vnet name -- az network vnet list --resource-group ${RG} --query "[].name" --output tsv


