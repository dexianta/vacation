#!/bin/bash

set -e

input=$(cat)

len=$(echo "$input" | yq 'keys | length')
if [ $len -ne 1 ]; then
  echo 'should have just one key'
  exit 5
fi 

key=$( echo "$input" | yq eval 'keys | .[0]' )

if yq e ".${key}" profile.yml > /dev/null; then
  echo "pre check pass"
else
  echo "user doesn't exist"
  exit 4
fi
