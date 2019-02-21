country=`awk -F "," '
{
	if ($7 == "2012"){
		countries[$1]+=$10
	}
}
END {
	for (country in countries){
		if (countries[country]>mx){
			mx=countries[country]
			ans=country;
		}
	}
	print ans
}
' < "$1"`

echo "Negara dengan penjualan terbanyak tahun 2012:  $country"

declare -a pL
for i in 1 2 3; do

	pL[$i]=`awk -F "," '
	{
		if ($7 == "2012" && $1 == "'"$country"'"){
			counter[$4]+=$10
		}
	}
	END{
		for (x in counter){
			print counter[x]","x
		}
	} ' < "$1" | sort -nr | awk -F "," '{ if (NR == "'"$i"'") print $2 }'`
done

echo "Top 3 Product line from $country"
for x in "${pL[@]}"; do
	echo $x
done

ans2=`awk -F "," '
/('"${pL[1]}"')|('"${pL[2]}"')|('"${pL[3]}"')/{
	if ($7 == "2012" && $1 == "'"$country"'"){
		counter2[$6]+=$10
	}
}
END{
	for (x in counter2){
		print counter2[x]","x
	}
}
' < "$1" | sort -nr | awk -F "," '{if (NR <= 3) print $2 }'`

echo "3 top product"
echo $ans2
