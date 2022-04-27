## Az + Powershell commands


# Get-AzureADUser

- proper login
Connect-AzAccount
$context=Get-AzContext
Connect-AzureAD -TenantId $context.Tenant.TenantId -AccountId $context.Account.Id

- login
az login

- list subscriptions
az account list  --output table

- change subscription
az account set --subscription <name or id>

## deployment 


from powershell prompt

set variables for date and deployment name
$date = Get-Date -Format "yyyy-MM-dd"
$deploymentName = "vfkafka" +"$date" + "a"




az deployment group create --name $deploymentName -g vfkafka-dev-wes-rg --parameters prj=vfkafka env=dev loc=wes deploy=$deploymentName -f .\main.bicep

followed by

az vm user update --resource-group  "vfkafka-dev-wes-rg" --name "vfkafka-dev-wes-vm-01" --username vmadmin --ssh-key-value c:/users/mansa/.ssh/kafkavm.pub

for all machines


start all vms in resource group
az vm start --ids $(az vm list -g vfkafka-dev-wes-rg --query "[].id" -o tsv)

deallocate vms powershell
$vms_ids= az vm list -g vfkafka-dev-wes-rg --query "[].id" -o tsv
az vm deallocate --ids $vms_ids

-c indicates dry run, remove to do actual deployment

- login with powershell
- connect 
Connect-AzAccount


## Associate with public ip address

( not needed as now pqwrt of template ) 

1. create public ip address in azure portal 
name standard: vfkafka-wes-vm-01-publicip

basic tier 
static 


2. associoate with vm

a) open public ip address overview in azure protal, click associate

b) select network interface as resource type

c) connect to nic of vm



## Connect with ssh

Connect via SSH with client

- Open the client of your choice, e.g. PuTTY or other clients.

- Ensure you have read-only access to the private key.
chmod 400 vmadmin.pem

- Provide a path to your SSH private key file.
Private key path
~/.ssh/vmadmin

Run the example command below to connect to your VM.
ssh -i ~/.ssh vmadmin@20.224.216.26
Can't connect?


ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.102









## Update ssh in azure existing Azure VM 
https://www.deepanseeralan.com/tech/update-ssh-keys-to-azure-vm/

- Generate keypair
ssh-keygen -m PEM -t rsa -b 4096 -f c:/users/mansa/.ssh/kafkavm -C vmadmin

( if using same key this only needs to be done once )

-- Update vm user with public key
az vm user update --resource-group  "vattenfall-kafka" --name "vfkafka-wes-vm-01" --username vmadmin --ssh-key-value c:/users/mansa/.ssh/kafkavm.pub

-- Login from windows command shell
ssh -i c:/users/mansa/.ssh/kafkavm  vmadmin@20.224.216.26 
ssh -i c:/users/mansa/.ssh/kafkavm  vmadmin@20.86.172.92

-- Login from wsl

cd ~/.ssh
cp /mnt/c/users/mansa/.ssh/kafkavm .
chmod 400 kafkavm
ssh -i ~/.ssh/kafkavm  vmadmin@20.224.216.26 
ssh -i ~/.ssh/kafkavm  vmadmin@20.86.172.92 

https://stackoverflow.com/questions/50277495/how-to-run-an-ansible-playbook-with-a-passphrase-protected-ssh-private-key

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/kafkavm

extend this with
https://stackoverflow.com/questions/13033799/how-to-make-ssh-add-read-passphrase-from-a-file
( not tested)


-- good firewall docs
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-controlling_traffic

firewall-cmd --list-all

firewall-cmd --list-ports

ssh -i ~/.ssh/kafkavm  vmadmin@20.224.216.26 




