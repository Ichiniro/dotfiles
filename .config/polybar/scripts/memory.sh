#!/bin/sh

echo "$(free -m --si | awk '/^Mem:/ {print $3}') MB"
