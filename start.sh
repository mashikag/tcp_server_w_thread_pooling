#!/bin/bash
if [ "$1" != ""]; then
  echo "You need to specify the port number as an argument."
else
  ruby server.rb $1
fi
