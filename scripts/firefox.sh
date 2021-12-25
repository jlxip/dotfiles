#!/bin/bash
bruh="$(ps x | grep firefox | grep -v grep | grep -v bash)"
if [ -z "$bruh" ]; then
	firefox &
	disown
else
	firefox --no-remote &
	disown
fi
