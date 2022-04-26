param prj string = 'vfkafka'
param env string = 'dev'
param loc string = 'wes'
param location string = 'westeurope'
param deploy string = 'westeurope'

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
    /* vmSize:'Standard_DS4_v2' PROD */


module vmServerModule 'vm.bicep' = {
  name: 'vmDeploy${deploy}Server'
  params: {
    prj:prj
    env:env
    loc:loc
    location:location
    subnetBasename:subnetBasename
    vnetBasename:vnetBasename  
    subnetPrefixBase:subnetPrefixBase  
    vmSize:'Standard_DS2_v2'
    number_of_VMs:3
    number_of_data_disks:1
    vmIdOffset:0
  }
}


/*

module vmClientModule 'vm.bicep' = {
  name: 'vmDeploy${deploy}Client'
  params: {
    prj:prj
    env:env
    loc:loc
    location:location
    subnetBasename:subnetBasename
    vnetBasename:vnetBasename  
    subnetPrefixBase:subnetPrefixBase  
    vmSize:'Standard_A2m_v2'
    number_of_VMs:3
    number_of_data_disks:1
    vmIdOffset:5
  }
}

*/
