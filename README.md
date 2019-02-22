# Soal Shift Modul 1 (Kelompok E6)

Soal Shift Modul 1 Sistem Operasi 2019:
* [Soal 1](https://github.com/jihannbl/SISOP2019-E6#soal-1)
* [Soal 2](https://github.com/jihannbl/SISOP2019-E6#soal-2)
* [Soal 3](https://github.com/jihannbl/SISOP2019-E6#soal-3)
* [Soal 4](https://github.com/jihannbl/SISOP2019-E6#soal-4)
* [Soal 5](https://github.com/jihannbl/SISOP2019-E6#soal-5)

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

 **_Jawaban:_**

* Buat script bash

   ```    
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

## Soal 3
Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:

a.	Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt

b.	Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

c.	Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

d.	Password yang dihasilkan tidak boleh sama.

**_Jawaban:_**

* Buat script bash

    ```
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

## Soal 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:

a.	Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

b.	Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

c.	Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

d.	Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

**_Jawaban:_**

* Buat script awk
 
   ```
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
 
