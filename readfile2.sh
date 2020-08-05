#!/bin/bash
filename="$1"
OLDIFS=$IFS
IFS=,
#[ ! -f $filename ] && { echo "$filename file not found"; exit 99; }
while read line vic;  do
    name="$line"
    echo "Name read from file - $name $vic"
    echo "sort your data the way you want using bash"
    echo $vic $name
done < "$filename"
