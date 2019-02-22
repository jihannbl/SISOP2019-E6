# Soal Shift Modul 1 (Kelompok E6)

###### Nama Anggota :
1. Ifta Jihan Nabila (05111740000034)
2. Komang Yogananda MW (05111740000114)

**Soal Shift Modul 1 Sistem Operasi 2019:**
* [Soal 1](https://github.com/jihannbl/SoalShift_modul1_E06-E6#Soal-1)
* [Soal 2](https://github.com/jihannbl/SoalShift_modul1_E06-E6#Soal-2)
* [Soal 3](https://github.com/jihannbl/SoalShift_modul1_E06-E6#Soal-3)
* [Soal 4](https://github.com/jihannbl/SoalShift_modul1_E06-E6#Soal-4)
* [Soal 5](https://github.com/jihannbl/SoalShift_modul1_E06-E6#Soal-5)

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

 **_Jawaban:_**

* Buat script bash

   ```bash
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
   ```   

  - `unzip "nature.zip"` untuk unzip isi dari nature.zip
  - `for f in nature/*` loop untuk setiap file (f) pada directory nature
  - `basename "$f"` untuk mendapatkan nama file dari variabel f yang disimpan ke variabel **filename**
  - `if [ ${f: -4} == ".jpg" ]` apabila 4 character terakhir dari nama file tersebut sama dengan ".jpg" maka 
    - perintah `base64 -d "$f"` dilakukan untuk mendekripsi data dari file (f). **base64** digunakan untuk mengenkripsi/mendekripsi data, lalu argumen **-d** dari perintah base64 digunakan untuk mendekripsi data. 
    - perintah `xxd -r > "nature/hasil_$filename"` dilakukan untuk mengembalikan hexdump ke bentuk aslinya dan menyimpannya pada directory nature dengan nama file hasil_$filename
    
    jika bukan, maka akan memberikan output "bukan jpg"
    
* Buat crontab untuk membuka file dengan sayarat pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

  `14 14 14 2 5 /home/jihan/soal1.sh` 
  
## Soal 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.

b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.

c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

**_Jawaban:_**

* script 2a
    ```bash
    #!/bin/bash

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
    ```

    Pertama-tama variabel country menyimpan nilai nama negara yang mempunyai kuantitas penjualan pada tahun 2012 terbanyak. Country dapat dicari dengan menggunakan script diatas. 
    - Awk digunakan untuk memeriksa setiap barisnya yaitu apabila kolom ke 7 (kolom tahun) merupakan 2012 maka array penghitung dengan index country tersebut ditambah dengan kolom 10 (kolom quantity). 
    - Diakhir awk cek isi dari array tersebut dan cari negara dengan penjualan terbanyak.

* script 2b
    ```bash
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
    ```

    Kemudian selanjutnya mencari 3 product line terbanyak dari country yang sudah di dapat. 
    - Deklarasikan array bernama pL. 
    - Iterasi sebanyak 3 kali dimana setiap iterasi menganduk sintaks awk yang memeriksa apakah suatu baris memiliki negara yang diinginkan dan tahun 2012. 
    - Keluaran awk tersebut di sort secara terbalik dan print sesuai indeks dari iterasi tersebut.

* script 2c
    ```bash
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
    ```

    Terakhir setelah memiliki 3 product line. Untuk mencari 3 product dengan penjualan terbanyak berdasarkan product line yang sudah didapatkan. Dengan menggunakan regex untuk mencari baris yang mengandung salah satu dari 3 product line yang didapat.

    - `/('"${pL[1]}"')|('"${pL[2]}"')|('"${pL[3]}"')/` regex untuk memeriksa apakah memenuhi salah satu dari 3 productline tersebut.

    Kemudian tidak lupa memeriksa apakah tahun merupakan 2012 dan negara merupakan country yang telah didapat.

Keterangan :

- `-F ","` sintaks tersebut untuk mendefinisikan field separator secara manual.
- `'"$var"'` digunakan untuk memasukkan variable bash kedalam sintaks awk.
- `${array[@]}` digunakan untuk mengeluarkan semua isi array.

## Soal 3
Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:

a.	Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt

b.	Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

c.	Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

d.	Password yang dihasilkan tidak boleh sama.

**_Jawaban:_**

* Buat script bash

    ```bash
    #!/bin/bash
    n="password"
    i=1

    while test -f "$n$i.txt"; do
    (( ++i ))
    done

    fname="$n$i.txt"
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > "$fname"
    ```
    
    - `while test -f "$n$i.txt"` untuk mengecek apakah terdapat file dengan nama "password$i.txt", jika ada maka increment i
    - `head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12` fungsi untuk random password yang memiliki huruf besar, huruf kecil, angka dan memiliki 12 karakter.
    - Password tersebut akan disimpan pada file password$i.txt
    - Misalkan file password1.txt sampai password6.txt telah dibuat, apabila password4.txt dihapus dan ingin membuat file baru lagi. Maka password tersebut akan disimpan ke file password4.txt bukan password7.txt karena pada `while test -f "$n$i.txt"` mengecek dari `i=1`

## Soal 4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

a.	Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.

b.	Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya. 

c.	setelah huruf z akan kembali ke huruf a

d.	Backup file syslog setiap jam.

e.	dan buatkan juga bash script untuk dekripsinya.

**_Jawaban:_**

1. Untuk [soal4.sh](https://github.com/jihannbl/SoalShift_modul1_E06/blob/master/soal4.sh)

2. Untuk [soal4_2.sh](https://github.com/jihannbl/SoalShift_modul1_E06/blob/master/soal4_2.sh)

**Command untuk enkripsi : bash soal4_2.sh -e**

* Buat script untuk enkripsi

  ```bash
  jam=`date +"%H"`
  filename=`date +"%H:%M %d-%m-%Y"`
  ```
  variabel **jam** untuk menyimpan jam saat ini. variabel **filename** untuk menyimpan nama file dengan format "jam:menit tanggal-bulan-tahun" saat ini
  
  ```bash
  function chr(){
  printf \\$(printf '%03o' $1)
  }

  a=`cat /var/log/syslog`

  chra=`chr $(($jam + 65))`
  chrz=`chr $(($jam + 65 - 1))`
  ```
  - fungsi **chr** disini untuk mengkonversi nilai decimal ke dalam ASCII. variabel **a** untuk menyimpan isi dari syslog. 
  
  - `$(($jam + 65))` digunakan untuk menjumlahkan variabel jam dengan 65 yang merupakan ASCII dari A, lalu disimpan pada variabel **chra** sebagai batas bawah untuk konversi hingga huruf Z.
  
  - `$(($jam + 65 - 1))` digunakan untuk menjumlahkan variabel jam dengan 65 yang merupakan ASCII dari A dikurangi 1 (sebelum A), lalu disimpan pada variabel **chrz** sebagai batas atas untuk konversi dari Z hingga chrz.
  
  
  ```bash
  function enkripsi(){
	if [ $jam -eq 0 ]
	then printf '%s' "$a" > "$filename"
	else
	r="$chra-ZA-$chrz"
	 printf '%s' "$a"| tr A-Za-z $r${r,,} > "$filename"
	fi
  }
  ```
  - fungsi **enkripsi**, apabila jam saat ini adalah 0 maka simpan ke dalam file dengan isi yang sama.
  
  - Jika tidak, maka isi file akan dienkripsi dengan menggunakan command **tr** A-Za-z dengan chra dan chrz yang tadi telah dihitung. `${r,,}` digunakan untuk lowercase. 
  
  - Lalu enkripsi disimpan ke dalam file dengan format yang ada pada $filename.
  

**Command untuk dekripsi : bash soal4_2.sh -d 'nama file yang ingin didekripsi'**
  
* Buat script untuk dekripsi 

  ```bash
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
  ```
  
  Tidak beda jauh penjelasannya dengan fungsi enkripsi, namun pada fungsi dekripsi terdapat variabel **jamD** yang diambil dari nama file. Untuk mendapatkan **jamD** maka terdapat perintah 
  
  ```bash
  filenameD=$2
  jamdekripsi=${filenameD:0:2}
  dekripsi "$2" "$jamdekripsi"
  ```
  untuk mengambil karakter dari index 0-2 pada nama file. 
  
  Lalu didekripsi dengan menukar posisi yang ada setelah command **tr**, dan akan disimpan pada file "dekripsi_'format file'".
  
* Crontab yang digunakan untuk backup syslog tiap jam

  `0 * * * * /home/jihan/soal4.sh -e`


## Soal 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:

a.	Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

b.	Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

c.	Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

d.	Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

**_Jawaban:_**

* Buat script awk
 
   ```bash
   #!/bin/bash

   cat /var/log/syslog | awk 'BEGIN {IGNORECASE = 1} /cron/ && !/sudo/ {print}' | awk 'NF < 13'
   ```
   
   - `cat /var/log/syslog` digunakan untuk menampilkan isi dari /var/log/syslog   
   - `awk 'BEGIN {IGNORECASE = 1} /cron/ && !/sudo/ {print}'` membuat pencarian string menjadi bersifat *tidak case sensitive* dan mencari record yang tidak memiliki string **sudo** namun memiliki string **cron**   
   - `awk 'NF < 13'` hanya menampilkan record yang memiliki jumlah field (dalam baris tersebut) kurang dari 13

* Buat crontab untuk menjalankan script setiap 6 menit dari menit ke 2 hingga 30, serta record tadi disimpan ke dalam file logs yang berada pada direktori /home/[user]/modul1.
  
  ```
  2-30/6 * * * * /home/jihan/nomer5.sh >> /home/jihan/modul1/nomer5.log 
  ```
 
