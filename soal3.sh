#!/bin/bash
n="password"
i=1

while test -e "$n$i.txt"; do
 (( ++i ))
done

fname="$n$i.txt"
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > "$fname"
