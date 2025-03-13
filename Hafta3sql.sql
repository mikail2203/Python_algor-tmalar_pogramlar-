--HAFTA 3
--Müþteriler tablosundaki Müþteri isimlerini ilk iki harfi , þirket harfinin ilk 3 harfi,Müþteri Unvanýnýn 5 6 7 harfleri ,Posta kodunun son 2 karakteri ile üretilen 
--kodun Müþteri ad soyad bilgisi ile birlikte Müþteri kod sutün ismi ile listelensin

select  MusteriAdi from Musteriler where MusteriAdi like '%%'
select MusteriAdi,left(MusteriAdi,2)+Right(SirketAdi,3)+Substring
(MusteriUnvani,5,3)+Right(PostaKodu,2) as MusteriKod from Musteriler

select MusteriAdi, CHARINDEX ('a',MusteriAdi) from Musteriler--ilk gördüðü a deðerini bulur ve bunun kaçýncý sýra olduðunu bulur
 --charindex: herhangi bir sutün içindeki verilerde karakter aramaya yarar (soldan saða doðru arar sonrakilerle ilgilenmez)
 --2 parametre alýr aranýlan karakter ve aranýlan karakterin sutünü bulur

 select Reverse (MusteriAdi) from Musteriler--Belirtilen sutündaki deðerleri tersten yazar.

 select Len(MusteriAdi) from Musteriler --sutündaki verinin uzunluðunu verir(Boþluklarda dahil).

 select replace (MusteriAdi,'A','XXX') from Musteriler--Belirttiðim sutunuda istediðim karakterleri istediðim þekilde görüntülenmesini saðlar

 select GETDATE ()--sistemin þuanki tarihini verir
 --Datepart(day/week/weekday/month/year/quarter):Tarih veri tipindeki sutündan tarihin istenilen kýsmýný listelemeye yarar.
 
select* from Personeller

Select DATEPART(day,IseBaslamaTarihi)as 'Gün' from Personeller--sutundaki gün bilgisini bana döndürür

select IseBaslamaTarihi,DATEPART(month,IseBaslamaTarihi) as 'Ay' from Personeller--Ay bilgisini verir
select IseBaslamaTarihi,DATEPART(YEAR,IseBaslamaTarihi) as 'Ay' from Personeller--yýl bilgisini verir
select IseBaslamaTarihi,DATEPART(WEEK,IseBaslamaTarihi) as 'Hafta' from Personeller--yýlýn kaçýncý haftasý olduðunu döndürür.
select IseBaslamaTarihi,DATEPART(WEEKDAY,IseBaslamaTarihi) as 'Ay' from Personeller--haftanýn kaçýncý günün verir
select IseBaslamaTarihi,DATEPART(QUARTER,IseBaslamaTarihi) as 'Ay' from Personeller--yýlým kaçýncý çeyreði olduðunu verir

--Datediff:iki tarih arasýndaki farký alýr.4 Parametresi vardir;day,week,month,year
select DATEDIFF(year,IseBaslamaTarihi,getdate()) from Personeller--personelin iþe giriþ tarihi ile bugünkü tarihi  çýkarýr
select DATEDIFF(MONTH,IseBaslamaTarihi,getdate()) from Personeller--Ýki tarih arasýnda kaç ay olduðunu gösterir
select DATEDIFF(week,IseBaslamaTarihi,getdate()) from Personeller
select DATEDIFF(DAY,IseBaslamaTarihi,getdate()) from Personeller

--Count:Belirtilen sutuundaki verilerin sayýsýný verir.Ka. satýra veri giriþi yapýldýðýný döndürür.Null deðerlerle ilgilenmez.SAyaç gibi çalýþýr.Verirnin ne olduðuyla ilgilenmez,var olup olmamasýyla ilgilenir.
select*from Musteriler
select count(*) from Musteriler--Müsteri tablosundaki kaýt giren sutunlarýn sayýsýný verir hepsini
select count(SirketAdi) from Musteriler--null deðerlerini getirmez
select count (Bolge) from Musteriler--bölge sutundaki toplam kayýt sayýsýný verir

--Distinc:Belirtilen sutundaki farklý verileri listeler.Tekrar eden verileri  yalnýzca bir kez listeler
select distinct Ulke from Musteriler
select count (Distinct Ulke) from Musteriler--sayýsný döndürür farklý ülkelerin
SORULAR:
--1-Satýþlar tablosunda her bir satýþýn kaç gün sonra ödendiðini bulunuz.
select * from Satislar
select DATEDIFF(day,OdemeTarihi,getdate()) from Satislar
Select DATEPART(day,OdemeTarihi)as 'ÖDEME' from Satislar
--2-Satýþ detaylarý tablosunda satýlan farklý ürünleri listeleyiniz.
select distinct  UrunID from [Satis Detaylari]

--3-Satýþlar Tablosunda hangi Müþterilere satýþ yapýldýðýný listeleyiniz
SELECT DISTINCT MusteriID 
FROM Satislar;
--4-satýþlar tablosunda 5 nolu personelin yaptýðý satýþlarýn hangi aylarda sevk edildiðini bulunuz.
SELECT DISTINCT MONTH(SevkTarihi) AS Sevk_Ayi
FROM Satislar
WHERE PersonelID = 5;
--5-Satýþlar tablosunda Venezuela'ya yapýlan satýþlarýn satýþtan kaç gün sonra sevk edildiðini bulunuz.
SELECT SatisID, DATEDIFF(day, SatisTarihi, SevkTarihi) AS Sevk_Suresi
FROM Satislar
WHERE SevkUlkesi = 'Venezuela';
--6-Satýþlar tablosundaki sevk þehirlerini en uzun isme sahip olanýn kaç karakterden oluþtuðunu bulunuz 
SELECT MAX(LEN(SevkSehri)) AS En_Uzun_Sehir_Ismi
FROM Satislar;
--7-Satýþlar tablosundaki her bir satýþ için;SevkAdresinin 2,3,4.Karakterleri Posta Kodunun ilk 2 rakamý,
--Sevk ,MüsteriID'nin ilk harfi,Ödeme ayý, MusteriID'nin ilk 3. harfi ,sevk yýlý birleþiminden oluþan bir satýþ kodu üretiniz.
SELECT 
    SatisID,
    CONCAT(
        SUBSTRING(SevkAdresi, 2, 3), -- Sevk Adresinin 2,3,4. karakterleri
        LEFT(SevkPostaKodu, 2), -- Posta kodunun ilk 2 rakamý
        LEFT(MusteriID, 1), -- Müþteri ID'nin ilk harfi
        MONTH(OdemeTarihi), -- Ödeme ayý
        LEFT(MusteriID, 3), -- Müþteri ID'nin ilk 3 harfi
        YEAR(SevkTarihi) -- Sevk yýlý
    ) AS Satis_Kodu
FROM Satislar;


 


