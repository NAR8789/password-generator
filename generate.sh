#!/bin/sh

LENGTH="$1"
LENGTH="${LENGTH:=4}"

command -v gshuf >/dev/null 2>&1 && SHUF=gshuf
command -v shuf  >/dev/null 2>&1 && SHUF=shuf
if [ -z "$SHUF" ]; then
  >&2 echo "could not find shuf or gshuf"
  exit 1
fi

"$SHUF" --repeat -n "$LENGTH" --random-source=/dev/urandom
