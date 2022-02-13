#!/bin/bash -x

# In my current config, that is,
# Artix 5.16.7, i7-4790k, AMD RX580:
# - No sleep times have been found to be necessary
# - Unbinding/binding efi-framebuffer makes everything not work randomly
# Current config is pretty stable :)

rc-service sddm stop
echo 'SDDM stopped'

echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 'vtcon0 unbinded'

echo 0 > /sys/class/vtconsole/vtcon1/bind
echo 'vtcon1 unbinded'

modprobe -r amdgpu
echo 'amdgpu removed'

virsh nodedev-detach pci_0000_01_00_0
echo 'detached 0'

virsh nodedev-detach pci_0000_01_00_1
echo 'detached 1'

modprobe vfio-pci
echo 'running vfio-pci'
