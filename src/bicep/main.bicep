param prj string = 'vfkafka'
param env string = 'dev'
param loc string = 'wes'
param location string = 'westeurope'

var  subnetBasename  = 'subnet-kafka'
var vnetBasename = 'vnet'

var addressPrefix = '10.0.0.0/16'
var subnetPrefix = '10.0.0.0/24'
var subnetPrefixBase = '10.0.0.'

/*
module infraModule 'infra.bicep' = {
  name: 'infraDeploy'
  params: {
    prj:prj
    env:env
    loc:loc
    location:location
    subnetBasename:subnetBasename
    vnetBasename:vnetBasename
    addressPrefix:addressPrefix
    subnetPrefix:subnetPrefix
  }
}

*/

module vmModule 'vm.bicep' = {
  name: 'vmDeploy'
  params: {
    prj:prj
    env:env
    loc:loc
    location:location
    subnetBasename:subnetBasename
    vnetBasename:vnetBasename  
    subnetPrefixBase:subnetPrefixBase  
  }
}
