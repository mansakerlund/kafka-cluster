#!/bin/bash

# setup datadisks
# https://developpaper.com/shell-script-quickly-create-format-mount-new-disk-implementation-method-details/

for V in $(ls /dev/sd[c-g])
do
 echo $V
 sudo parted $V  --script mklabel gpt mkpart xfspart xfs 0% 100%

 sudo mkfs.xfs -f $V

 sudo partprobe $V

 sleep 2

 M=$(echo "$V" |awk -F "/" '{print $3}')
 sudo mkdir -p /data/${M}1 &>/dev/null
 sudo echo -e "${V}1 /datadrive/${M}1 xfs defaults,nofail 1 2\n" >>/etc/fstab
 sudo mount -a $V /data/${M}1 &>/dev/null

done