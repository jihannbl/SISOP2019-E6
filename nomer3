#!/bin/bash
n="password"
i=1
a=1
while test -e "$n$a.txt"; do
 (( ++i ))
a=$i
done
fname="$n$a.txt"
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > "$fname"
