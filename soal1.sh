#!/bin/bash

log=`unzip "nature.zip"`
for f in nature/*; do
	filename=`basename "$f"`
	if [ ${f: -4} == ".jpg" ]; then
		`base64 -d "$f" | xxd -r > "nature/hasil_$filename"`
	else
		echo "bukan jpg"
	fi
done
