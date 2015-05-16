#!/bin/sh

LENGTH="$1"
LENGTH="${LENGTH:=4}"

shuf -n"$LENGTH" --random-source=/dev/urandom
