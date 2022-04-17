// inspired by https://medium.com/codex/deploying-jboss-as-wildfly-on-centos-using-bicep-4eef5206318f

param prj string = 'vfkafka'
param env string = 'dev'
param loc string = 'wes'
param location string = 'westeurope'

param subnetBasename string = 'subnet-kafka'
param vnetBasename string = 'vnet'
param subnetPrefixBase string

var subnetName = '${prj}-${env}-${loc}-${subnetBasename}'
var virtualNetworkName_var = '${prj}-${env}-${loc}-${vnetBasename}'

@description('Linux VM user account name')
param adminUsername string = 'vmadmin'

@allowed([
  'password'
  'sshPublicKey'
])
@description('Type of authentication to use on the Virtual Machine')
param authenticationType string = 'password'

@description('Password or SSH key for the Virtual Machine')
@secure()
param adminPasswordOrSSHKey string = 'x6&4BMaRdJ+B_h5Z'


@description('The size of the Virtual Machine')

// param vmSize string = 'Standard_D2s_v3'
//param vmSize string = 'Standard_D4s_v3'
// param vmSize string = 'Standard_A2m_v2' // throughput wiyh only os disk 15000 msg/s
param vmSize string = 'Standard_DS11'


var singlequote = '\''
var imagePublisher = 'OpenLogic'
var imageOffer = 'CentOS'
var imageSKU = '8.0'
var storageAccountType = 'Standard_LRS'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrSSHKey
      }
    ]
  }
}
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_var, subnetName)


// var bootStorageAccountName_var = 'bootstrg${uniqueString(resourceGroup().id)}'



resource bootStorageAccountName 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(0, 3): {
  name: 'bootstrg${i+1}${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'Storage'
  tags: {
    QuickstartName: 'Vattenfall Centos 8 (stand-alone VM)'
  }
}]

resource virtualNetworkName 'Microsoft.Network/virtualNetworks@2019-11-01' existing = {
  name: virtualNetworkName_var
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-11-01' = [for i in range(0, 3 ):{
  name: '${prj}-${env}-${loc}-vm-0${i+1}-publicip'
  location: location
      sku: {
          name: 'Basic'
          tier: 'Regional'
      }
      properties: {        
        publicIPAddressVersion: 'IPv4'
        publicIPAllocationMethod: 'Static'
        idleTimeoutInMinutes: 4        
      }      
}]



resource nicName 'Microsoft.Network/networkInterfaces@2019-11-01' = [for i in range(0, 3): {
  name: '${prj}-${env}-${loc}-0${i+1}-nic'
  location: location
  tags: {
    QuickstartName: 'Vattenfall Centos 8 (stand-alone VM)'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '${subnetPrefixBase}${i+11}'
          publicIPAddress: {
            id: publicIp[i].id
          }
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
  }
  dependsOn: [
    virtualNetworkName
  ]
}]

resource vmName 'Microsoft.Compute/virtualMachines@2019-12-01' = [for i in range(0, 3 ):{
  name: '${prj}-${env}-${loc}-vm-0${i+1}'
  location: location
  tags: {
    QuickstartName: 'Vattenfall Centos 8 (stand-alone VM)'
  }
  properties: {
    hardwareProfile: {      
      vmSize: vmSize
    }
    osProfile: {
      computerName: '${prj}-${env}-${loc}-vm-0${i+1}'
      adminUsername: adminUsername
      adminPassword: adminPasswordOrSSHKey
      linuxConfiguration: ((authenticationType == 'password') ? json('null') : linuxConfiguration)
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSKU
        version: 'latest'
      }
      osDisk: {
        name: '${prj}-${env}-${loc}-vm-0${i+1}_OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
      dataDisks: [for disk in range(0, 6 ) : {
            name: '${prj}-${env}-${loc}-vm-0${i+1}-datadisk${disk}'
            diskSizeGB: 64
            lun: disk
            'createOption': 'Empty'
      }]    
  }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicName[i].id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: reference(bootStorageAccountName[i].name, '2021-02-01').primaryEndpoints.blob
      }
    }
  }
  dependsOn: [
    bootStorageAccountName[i]
  ]
}]



// output vm_Private_IP_Address string = nicName.properties.ipConfigurations[0].properties.privateIPAddress


