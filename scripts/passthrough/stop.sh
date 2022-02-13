#!/bin/bash -x

modprobe -r vfio-pci
echo 'vfio-pci removed'

virsh nodedev-reattach pci_0000_01_00_0
echo 'reattached 0'

virsh nodedev-reattach pci_0000_01_00_1
echo 'reattached 1'

modprobe amdgpu
echo 'amdgpu loaded'

echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 'vtcon0 binded'

echo 1 > /sys/class/vtconsole/vtcon1/bind
echo 'vtcon1 binded'

rc-service sddm start
echo 'there goes sddm'
