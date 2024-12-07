echo "please enter the number"

read number

echo "you entered the number is: $number"

i=0

while [ $i -le $number ]
do
i=$((i+2))
echo "Even numbers are $i"

done