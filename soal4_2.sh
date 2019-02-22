#/var/log/syslog
jam=`date +"%H"`
filename=`date +"%H:%M %d-%m-%Y"`
jamdekripsi=0

function enkripsi(){
	`awk '
	BEGIN{
		for (n=0;n<256;n++){
			ord[sprintf("%c",n)]=n
			chr[n]=sprintf("%c",n)
		}
	}
	{
		split($0, chars, "")
		for (i=1;i<=length($0);i++){
			x=ord[chars[i]]
			if (x > 96 && x < 123) {
				x=x+'"$jam"';
				if (x > 122) x=97+(x%123)
			}else if (x > 64 && x < 91) {
				x=x+'"$jam"';
				if (x > 90) x=65+(x%91)
			}
			printf ("%s", chr[x])
		}
		printf("\n")
	}
	' < "/var/log/syslog" > "$filename"`
}

function dekripsi(){
	jamD=$2
	`awk '
	BEGIN{
		for (n=0;n<256;n++){
			ord[sprintf("%c",n)]=n
			chr[n]=sprintf("%c",n)
		}
	}
	{
		split($0, chars, "")
		for (i=1;i<=length($0);i++){
			x=ord[chars[i]]
			if (x > 96 && x < 123) {
				x=x-'"$jamD"';
				if (x < 97) x=122-(96-x)
			}else if (x > 64 && x < 91) {
				x=x-'"$jamD"';
				if (x < 65) x=90-(64-x)
			}
			printf ("%s", chr[x])
		}
		printf("\n")
	}
	' < "$1" > "dekripsi_$1"`
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
