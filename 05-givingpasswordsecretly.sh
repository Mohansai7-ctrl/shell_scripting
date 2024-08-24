#!/bin/bash

#Here im giving the username and password in both read mode and secret modes.

echo "Please enter your Username:"
read Username
echo "Hi, My Username is $Username"

#giving pwd secrectly by using -s

echo "Now enter your password:"
read -s Password
echo "your password is: $Password" 
echo "Thank you, you logged in"