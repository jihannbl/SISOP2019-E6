#!/bin/bash
jam=`date +"%H"`
filename=`date +"%H:%M %d-%m-%Y"`
jamdekripsi=0

function chr(){
  printf \\$(printf '%03o' $1)
}

a=`cat /var/log/syslog`

chra=`chr $(($jam + 65))`
chrz=`chr $(($jam + 65 - 1))`

function enkripsi(){
	if [ $jam -eq 0 ]
	then printf '%s' "$a" > "$filename"
	else
	r="$chra-ZA-$chrz"
	 printf '%s' "$a"| tr A-Za-z $r${r,,} > "$filename"
	fi
}

function dekripsi(){
	jamD=$2
	b=`cat "$1"`

	chra=`chr $(($jamD + 65))`
	chrz=`chr $(($jamD + 65 - 1))`
	if [ $jamD -eq 0 ]
	then printf '%s' "$b" > "dekripsi_$1"
	else
	r="$chra-ZA-$chrz"
	 printf '%s' "$b" | tr $r${r,,} A-Za-z > "dekripsi_$1"
	fi
}

case $1 in
	"-e")
		enkripsi
		;;
	"-d")
		echo "dekripsi $2"
		filenameD=$2
		jamdekripsi=${filenameD:0:2}
		dekripsi "$2" "$jamdekripsi"
		;;
	*)
		echo "Tidak ada mode dipilih, -e untuk enkripsi -d 'nama_file' untuk dekripsi"
		;;
esac
