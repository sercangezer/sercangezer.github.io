---
layout      : post
title       : "Dosyaları Yıl ve Ay olarak klasörlere ayırma"
description : "Dosyaları yıl ve ay bilgisine göre klasörlere ayıran script"
tags        : [Linux, Windows, Powershell, Bash]
---
# Problem
Oracle JD Edwards ile yapılan işlerin rapor (UBE) dosyalarını NAS sunucularımızda yedekliyoruz. Fakat gelişigüzel bir sistemle attığımız için bir rapor dosyası aradığımızda milyonlarca dosya içinden bulmamız çok uzun zaman alıyordu. 

# Çözüm

Bunun için NAS sunucusu içerisinde raporları yıllara ve aylara göre ayıran aşağıdaki scripti internetten bulup, düzenlemeler yaptım.

# Linux (Bash)

```bash
## Bütün dosyaların bulunduğu klasörün yolu
BASE_DIR=/yedek-sunucusu/klasorler/duzenlenecek-klasor

## Find komutu ile BASE_DIR klasörü içindeki dosyaları buluyoruz.
find "$BASE_DIR" -maxdepth 1  -type f -name "*" |
 while IFS= read -r file; do
 ## Dosyanın oluşturulma yıl bilgisini alıyoruz.
 year="$(date -d "$(stat -c %y "$file")" +%Y)"
 ## Dosyanın oluşturulma ay bilgisini alıyoruz.
 month="$(date -d "$(stat -c %y "$file")" +%b)"

 ## Yıl ve ay'a ait klasör yoksa oluşturuyoruz.
 [[ ! -d "$BASE_DIR/$year/$month" ]] && mkdir -p "$BASE_DIR/$year/$month";
 
 ## Dosyayı yıl/ay olacak şekilde klasöre taşıyoruz.
 mv "$file" "$BASE_DIR/$year/$month"
 ## Taşınan dosyanın hangi klasöre taşındığını terminalde göstermesini sağlıyoruz.
 echo $file - $year/$month klasorune tasindi. 
done

```

## Script'in mantığı

`BASE_DIR` ile belirtilen klasör içerisinde bulunan bütün dosyaların (_find "$BASE_DIR" -maxdepth 1  -type f -name "*"_), yıl ve ay bilgilerini alıp, oluşturulma tarihine göre (2018 Jun) gibi klasör oluşturup içine taşıyoruz.

```
2019
	-- Jan
	-- Feb
	-- Mar
2018
	-- Jan
	-- Apr
	-- May
	-- Sep
```
gibi bir hiyeraşi ile dosyaları taşıma yapıyor.

# Windows (PowerShell)


```powershell
# Get the files which should be moved, without folders
$files = Get-ChildItem 'C:\Users\jdedev\Desktop\SOURCE' -Recurse | where {!$_.PsIsContainer}
 
# List Files which will be moved
$files
 
# Target Filder where files should be moved to. The script will automatically create a folder for the year and month.
$targetPath = 'C:\Users\jdedev\Desktop\DESTINATION'
 
foreach ($file in $files)
{
# Get year and Month of the file
# I used LastWriteTime since this are synced files and the creation day will be the date when it was synced
$year = $file.LastWriteTime.Year.ToString()
$month = $file.LastWriteTime.Month.ToString()
 
# Out FileName, year and month
$file.Name
$year
$month
 
# Set Directory Path
$Directory = $targetPath + "\" + $year + "\" + $month
# Create directory if it doesn't exsist
if (!(Test-Path $Directory))
{
New-Item $directory -type directory
}
 
# Move File to new location
$file | Move-Item -Destination $Directory
}

```

[Kaynak](https://www.thomasmaurer.ch/2015/03/move-files-to-folder-sorted-by-year-and-month-with-powershell/)
