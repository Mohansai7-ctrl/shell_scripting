#!/bin/bash

#This help you on how to use array in shell scripting

Fruits=("Apples" "Oranges" "Grapes")

echo "Provided array contains 3 fruits, Oth element in given list is: ${Fruits[0]}"
echo "In the given list of array, second element is: ${Fruits[2]}"
echo "All the fruits in given list are: ${Fruits[@]}"