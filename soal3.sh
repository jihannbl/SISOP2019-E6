#!/bin/bash
n="password"
i=1

function random(){
   local inipass=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
   echo $inipass
}

pass=`random`

while test -f "$n$i.txt"; do
  if [ "$pass" == "`cat $n$i.txt`" ]
  then
   i=1
   pass=`random`
  else (( ++i ))
  fi
done

fname="$n$i.txt"
echo $pass > "$fname"
