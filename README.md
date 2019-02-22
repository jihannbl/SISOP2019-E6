# Soal Shift Modul 1 (Kelompok E6)

Soal Shift Modul 1 Sistem Operasi 2019:

## Soal 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump
    
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
  2-30/6 * * * * /home/jihan/nomer5.sh >> /home/jihan/modul1/nomer5.log 2>&1
  ```
  