# Set variables
RG="azurecli"
vnet="MyVnet"
subnet="MySubnet"
vm="cli-vm"

# Create a resource group
echo "Creating resource group: $RG"
az group create --name $RG --location canadacentral

echo "Creating Virtual Network: $vnet with Subnet: $subnet"
az network vnet create -g $RG -n $vnet\
  --address-prefix 10.0.0.0/16 \
  --subnet-name $subnet \
  --subnet-prefix 10.0.0.0/24 \
  --location canadacentral

# Create a virtual machine
echo "Creating Virtual Machine: $vm"
az vm create -g $RG -n $vm\
  --image Ubuntu2204 \
  --vnet-name $vnet \
  --subnet $subnet \
  --admin-username azureuser \
  --authentication-type ssh \
  --public-ip-sku Standard \
  --size Standard_B1s \
  --nsg-rule SSH \
  --public-ip-address-dns-name $vm

