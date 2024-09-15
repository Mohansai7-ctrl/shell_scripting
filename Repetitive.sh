#!/bin/bash

echo "Please provide the input file"
read $input

echo "You selected this $input file"

while IFS= read -r line
do


done <<< $input