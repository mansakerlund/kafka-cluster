param prj string = 'vfkafka'
param env string = 'dev'
param loc string = 'wes'
param location string = 'westeurope'

param subnetBasename string = 'subnet-kafka'
param vnetBasename string = 'vnet'

param addressPrefix string = '10.0.0.0/16'
param subnetPrefix string = '10.0.0.0/24'


var subnetName = '${prj}-${env}-${loc}-${subnetBasename}'
var virtualNetworkName_var = '${prj}-${env}-${loc}-${vnetBasename}'

resource virtualNetworkName 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualNetworkName_var
  location: location
  tags: {
    QuickstartName: 'Vattenfall Centos 8 (stand-alone VM)'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}


