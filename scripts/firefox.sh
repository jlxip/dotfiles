#!/bin/bash
bruh="$(ps x | grep firefox | grep -v grep)"
if [ -z "$bruh" ]; then
	firefox &
	disown
else
	firefox --no-remote &
	disown
fi
