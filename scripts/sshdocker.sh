#!/bin/bash

SOCK='/tmp/ssh-docker.sock'

if [ -e $SOCK ]; then
	rm $SOCK
fi

if [ -z $1 ]; then
	echo "Give remote 😦"
	exit 1
fi

ssh -L $SOCK:/var/run/docker.sock $1
