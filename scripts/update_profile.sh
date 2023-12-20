#!/bin/bash

input=$(cat)

key=$( echo "$input" | yq eval 'keys | .[0]' )
updated=$(yq e ".${key}" vacation.yml | awk '{print $2}' | cut -d '-' -f1 |  sort | uniq -c | awk '{print $2": "$1}' | yq e "{ \"${key}\": {\"counts\": .} }" -P)
echo "$updated" | yq ea 'select(fi==0) *+ select(fi==1) // {}' - profile.yml -P
