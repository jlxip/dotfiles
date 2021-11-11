#!/bin/bash
bruh="$(ps -e | egrep 'firefox$')"
if [ -z "$bruh" ]; then
	firefox &
	disown
else
	firefox --no-remote &
	disown
fi
