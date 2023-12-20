#!/bin/bash

set -e

input=$(cat)

len=$(echo "$input" | yq 'keys | length')
if [ "$len" -ne 1 ]; then
  echo 'should have just one key'
  exit 1
fi 

key=$( echo "$input" | yq eval 'keys | .[0]' )
input=$( echo "$input" | yq ea ".${key} |= map (format_datetime(\"2006-01-02 Monday\"))" )

echo "$input" | yq ea 'select(fi==0) *+ select(fi==1) // {}' - vacation.yml | yq ea '.[] |= unique' -P
