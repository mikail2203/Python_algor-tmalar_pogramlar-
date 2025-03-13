--HAFTA 3
--M��teriler tablosundaki M��teri isimlerini ilk iki harfi , �irket harfinin ilk 3 harfi,M��teri Unvan�n�n 5 6 7 harfleri ,Posta kodunun son 2 karakteri ile �retilen 
--kodun M��teri ad soyad bilgisi ile birlikte M��teri kod sut�n ismi ile listelensin

select  MusteriAdi from Musteriler where MusteriAdi like '%%'
select MusteriAdi,left(MusteriAdi,2)+Right(SirketAdi,3)+Substring
(MusteriUnvani,5,3)+Right(PostaKodu,2) as MusteriKod from Musteriler

select MusteriAdi, CHARINDEX ('a',MusteriAdi) from Musteriler--ilk g�rd��� a de�erini bulur ve bunun ka��nc� s�ra oldu�unu bulur
 --charindex: herhangi bir sut�n i�indeki verilerde karakter aramaya yarar (soldan sa�a do�ru arar sonrakilerle ilgilenmez)
 --2 parametre al�r aran�lan karakter ve aran�lan karakterin sut�n� bulur

 select Reverse (MusteriAdi) from Musteriler--Belirtilen sut�ndaki de�erleri tersten yazar.

 select Len(MusteriAdi) from Musteriler --sut�ndaki verinin uzunlu�unu verir(Bo�luklarda dahil).

 select replace (MusteriAdi,'A','XXX') from Musteriler--Belirtti�im sutunuda istedi�im karakterleri istedi�im �ekilde g�r�nt�lenmesini sa�lar

 select GETDATE ()--sistemin �uanki tarihini verir
 --Datepart(day/week/weekday/month/year/quarter):Tarih veri tipindeki sut�ndan tarihin istenilen k�sm�n� listelemeye yarar.
 
select* from Personeller

Select DATEPART(day,IseBaslamaTarihi)as 'G�n' from Personeller--sutundaki g�n bilgisini bana d�nd�r�r

select IseBaslamaTarihi,DATEPART(month,IseBaslamaTarihi) as 'Ay' from Personeller--Ay bilgisini verir
select IseBaslamaTarihi,DATEPART(YEAR,IseBaslamaTarihi) as 'Ay' from Personeller--y�l bilgisini verir
select IseBaslamaTarihi,DATEPART(WEEK,IseBaslamaTarihi) as 'Hafta' from Personeller--y�l�n ka��nc� haftas� oldu�unu d�nd�r�r.
select IseBaslamaTarihi,DATEPART(WEEKDAY,IseBaslamaTarihi) as 'Ay' from Personeller--haftan�n ka��nc� g�n�n verir
select IseBaslamaTarihi,DATEPART(QUARTER,IseBaslamaTarihi) as 'Ay' from Personeller--y�l�m ka��nc� �eyre�i oldu�unu verir

--Datediff:iki tarih aras�ndaki fark� al�r.4 Parametresi vardir;day,week,month,year
select DATEDIFF(year,IseBaslamaTarihi,getdate()) from Personeller--personelin i�e giri� tarihi ile bug�nk� tarihi  ��kar�r
select DATEDIFF(MONTH,IseBaslamaTarihi,getdate()) from Personeller--�ki tarih aras�nda ka� ay oldu�unu g�sterir
select DATEDIFF(week,IseBaslamaTarihi,getdate()) from Personeller
select DATEDIFF(DAY,IseBaslamaTarihi,getdate()) from Personeller

--Count:Belirtilen sutuundaki verilerin say�s�n� verir.Ka. sat�ra veri giri�i yap�ld���n� d�nd�r�r.Null de�erlerle ilgilenmez.SAya� gibi �al���r.Verirnin ne oldu�uyla ilgilenmez,var olup olmamas�yla ilgilenir.
select*from Musteriler
select count(*) from Musteriler--M�steri tablosundaki ka�t giren sutunlar�n say�s�n� verir hepsini
select count(SirketAdi) from Musteriler--null de�erlerini getirmez
select count (Bolge) from Musteriler--b�lge sutundaki toplam kay�t say�s�n� verir

--Distinc:Belirtilen sutundaki farkl� verileri listeler.Tekrar eden verileri  yaln�zca bir kez listeler
select distinct Ulke from Musteriler
select count (Distinct Ulke) from Musteriler--say�sn� d�nd�r�r farkl� �lkelerin
SORULAR:
--1-Sat��lar tablosunda her bir sat���n ka� g�n sonra �dendi�ini bulunuz.
select * from Satislar
select DATEDIFF(day,OdemeTarihi,getdate()) from Satislar
Select DATEPART(day,OdemeTarihi)as '�DEME' from Satislar
--2-Sat�� detaylar� tablosunda sat�lan farkl� �r�nleri listeleyiniz.
select distinct  UrunID from [Satis Detaylari]

--3-Sat��lar Tablosunda hangi M��terilere sat�� yap�ld���n� listeleyiniz
SELECT DISTINCT MusteriID 
FROM Satislar;
--4-sat��lar tablosunda 5 nolu personelin yapt��� sat��lar�n hangi aylarda sevk edildi�ini bulunuz.
SELECT DISTINCT MONTH(SevkTarihi) AS Sevk_Ayi
FROM Satislar
WHERE PersonelID = 5;
--5-Sat��lar tablosunda Venezuela'ya yap�lan sat��lar�n sat��tan ka� g�n sonra sevk edildi�ini bulunuz.
SELECT SatisID, DATEDIFF(day, SatisTarihi, SevkTarihi) AS Sevk_Suresi
FROM Satislar
WHERE SevkUlkesi = 'Venezuela';
--6-Sat��lar tablosundaki sevk �ehirlerini en uzun isme sahip olan�n ka� karakterden olu�tu�unu bulunuz 
SELECT MAX(LEN(SevkSehri)) AS En_Uzun_Sehir_Ismi
FROM Satislar;
--7-Sat��lar tablosundaki her bir sat�� i�in;SevkAdresinin 2,3,4.Karakterleri Posta Kodunun ilk 2 rakam�,
--Sevk ,M�steriID'nin ilk harfi,�deme ay�, MusteriID'nin ilk 3. harfi ,sevk y�l� birle�iminden olu�an bir sat�� kodu �retiniz.
SELECT 
    SatisID,
    CONCAT(
        SUBSTRING(SevkAdresi, 2, 3), -- Sevk Adresinin 2,3,4. karakterleri
        LEFT(SevkPostaKodu, 2), -- Posta kodunun ilk 2 rakam�
        LEFT(MusteriID, 1), -- M��teri ID'nin ilk harfi
        MONTH(OdemeTarihi), -- �deme ay�
        LEFT(MusteriID, 3), -- M��teri ID'nin ilk 3 harfi
        YEAR(SevkTarihi) -- Sevk y�l�
    ) AS Satis_Kodu
FROM Satislar;


 


