#!/bin/sh -e
echo device_specific > /sys/bus/pci/devices/0000\:01\:00.0/reset_method
