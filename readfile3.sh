#!/bin/bash
filename="$1"
OLDIFS=$IFS
IFS=,
#[ ! -f $filename ] && { echo "$filename file not found"; exit 99; }
while read person role  email number;  do
    name="$person"
    echo "Welcome $name to Teknixco"
    echo "According to your resume, you will be a $role."
    echo "Other members may contact you at $number or $email"
    echo "Please verify your credentials are true"
    echo "Person: $person"
    echo "Role: $role"
    echo "E-Mail Address: $email"
    echo "Phone Number: $number"
done < "$filename"
