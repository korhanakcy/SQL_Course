CREATE TABLE Musteriler(
	MusteriID SERIAL PRIMARY KEY,
	Isim VARCHAR(50),
	Soyisim VARCHAR(50),
	Email VARCHAR(50),
	telefon VARCHAR(15),
	Adres VARCHAR(250),
	Sehir VARCHAR(50),
	Ulke VARCHAR(50)
);

INSERT INTO Musteriler(Isim, Soyisim, Email, Telefon, Adres, Sehir, Ulke)
VALUES
('Ali', 'Yılmaz', 'ali.yilmaz@example.com','5551234567', 'Caddesi 123', 'Ankara', 'Türkiye'),
('Ayşe', 'Demir', 'ayse.demir@example.com','5552345678', 'Sokak 456', 'İstanbul', 'Türkiye'),
('Mehmet', 'Kaya', 'mehmet.kaya@example.com','5551234589', 'Caddesi 789', 'İzmir', 'Türkiye'),
('Fatma', 'Yıldız', 'fatma.yıldız@example.com','5554567123', 'Mahalle 987', 'Antalya', 'Türkiye'),
('Ahmet', 'Taylan', 'ahmet.taylan@example.com','5551236789', 'Sokak 654', 'Bursa', 'Türkiye'),
('Emine', 'Çelik', 'emine.celik@example.com','5552341112', 'Merkez 123', 'Adana', 'Türkiye'),
('Hasan', 'Şahin', 'hasan.sahin@example.com','5557890123', 'Daire 123', 'Trabzon', 'Türkiye'),
('Zeynep', 'Öztürk', 'zeynep.ozturk@example.com','5558901234', 'Mahalle 123', 'Konya', 'Türkiye'),
('Mustafa', 'Aydın', 'mustafa.aydin@example.com','5559012345', 'Caddesi 321', 'Mersin', 'Türkiye'),
('Hatice', 'Çetin', 'hatice.cetin@example.com','5550123456', 'Sokak 789', 'Eskişehir', 'Türkiye');



CREATE TABLE Urunler(
	URUNID Serial PRIMARY KEY,
	UrunAdi VARCHAR(100),
	KategoriID INT,
	Fiyat DECIMAL(10,2),
	Stok INT
);

INSERT INTO Urunler(UrunAdi, KategoriID, Fiyat, Stok)
VALUES
('Laptop', 1, 75000.00, 50),
('Akıllı Telefon', 1, 35000.00, 150),
('Kulaklık', 2, 150.00,300),
('Tablet', 1, 2000.00, 100),
('Klavye', 2, 200.00, 200),
('Monitör', 1, 1200.00, 75),
('Fare', 2, 100.00, 250),
('Yazıcı', 3, 600.00, 50),
('Webcam', 2, 250.00, 150),
('Hard Disk', 3, 400.000, 100);


CREATE TABLE Siparisler (
    SiparisID SERIAL PRIMARY KEY,
    MusteriID INT,
    SiparisTarihi DATE,
    ToplamTutar DECIMAL(10, 2)
);

INSERT INTO Siparisler (MusteriID, SiparisTarihi, ToplamTutar) VALUES
(1, '2024-07-01', 850.00),
(2, '2024-07-02', 1500.00),
(3, '2024-07-03', 600.00),
(4, '2024-07-04', 2300.00),
(5, '2024-07-05', 1200.00),
(6, '2024-07-06', 750.00),
(7, '2024-07-07', 3000.00),
(8, '2024-07-08', 450.00),
(9, '2024-07-09', 800.00),
(10, '2024-07-10', 350.00);


CREATE TABLE SiparisDetaylari (
    SiparisDetayID SERIAL PRIMARY KEY,
    SiparisID INT,
    UrunID INT,
    Miktar INT,
    BirimFiyat DECIMAL(10, 2)
);

INSERT INTO SiparisDetaylari (SiparisID, UrunID, Miktar, BirimFiyat) VALUES
(1, 1, 1, 7500.00),
(1, 4, 2, 2000.00),
(2, 2, 1, 3500.00),
(2, 5, 2, 200.00),
(3, 6, 1, 1200.00),
(3, 3, 1, 2000.00),
(4, 7, 1, 100.00),
(4, 8, 1, 600.00),
(4, 9, 2, 250.00),
(5, 10, 3, 400.00),
(6, 2, 1, 3500.00),
(7, 1, 1, 7500.00),
(8, 3, 1, 2000.00),
(9, 4, 1, 150.00),
(10, 5, 1, 200.00);


CREATE TABLE Kategoriler (
    KategoriID SERIAL PRIMARY KEY,
    KategoriAdi VARCHAR(50)
);

INSERT INTO Kategoriler (KategoriAdi) VALUES
('Elektronik'),
('Aksesuarlar'),
('Ofis Ekipmanları');


-- SELECT ve FROM 

-- Müşteriden tüm müşterileri seçelim

SELECT *
FROM Musteriler;

SELECT UrunAdi, Fiyat
FROM urunler;

-- WHERE -> Filtreleme yöntemi

-- Ankara'daki müşteriyi getir

SELECT * 
FROM Musteriler
WHERE Sehir = 'Ankara';


-- Fiyatı 2000'den büyük ürünleri gelsin

SELECT UrunAdi, Fiyat
FROM urunler
WHERE Fiyat > 2000.00;


-- LIMIT -> Sınırlandırma, python, r, head(), ilk belirli birkaç değerleri sınırlıyordu.

-- Müşteri tablosundan ilk 5 müşteriyi seçelim

SELECT *
FROM musteriler
LIMIT 5;

-- Ürün tablosundan fiyatı en yüksek 3 ürünü 

SELECT UrunAdi
FROM Urunler
ORDER BY Fiyat DESC
LIMIT 3;

-- JOIN -- ON --> Birden fazla tabloyu birleştirmek ve daha anlamlı sonuçları elde etmek için kullanıyoruz.

-- Siparişler ve Müşteriler tablolalarını birleştirelim

SELECT Siparisler.SiparisID, Musteriler.Isim, Musteriler.Soyisim, Siparisler.ToplamTutar
FROM Siparisler
JOIN Musteriler ON Siparisler.MusteriID = Musteriler.MusteriID;

-- Ankara'da yaşayan müşterilerin verdiği siparisler

SELECT SiparisID, Musteriler.Isim, Musteriler.Soyisim, Siparisler.ToplamTutar
FROM Siparisler
JOIN Musteriler ON Siparisler.MusteriID = Musteriler.MusteriID
WHERE Musteriler.Sehir = 'Ankara';

-- Fiyatı 1000 TL'den yüksek olan ürünlerin sipariş detaylarını seçelim ve ilk 4 değeri gösterelim.

SELECT SiparisDetaylari.SiparisID, Urunler.UrunAdi, SiparisDetaylari.Miktar, SiparisDetaylari.BirimFiyat
FROM SiparisDetaylari
JOIN Urunler ON SiparisDetaylari.UrunID = Urunler.UrunID
WHERE Urunler.Fiyat > 1000
LIMIT 4;


-- DISTINCT --> Unique olan değerleri getirir.

SELECT DISTINCT BirimFiyat
FROM SiparisDetaylari;

-- AGGREGATE FUNCTIONS: COUNT, SUM, AVG, MİN, MAX, GROUP BY, HAVING

-- count 
-- Toplam müşteri sayısını 

SELECT COUNT(*) AS ToplamMusteri
FROM Musteriler;

-- Her kategorideki ürün sayısı

SELECT KategoriID, COUNT(*) AS Urun_Sayısı
FROM Urunler
GROUP BY KategoriID;

-- SUM

-- Tüm siparişlerin toplam tutarını bulalım

SELECT SUM(ToplamTutar) AS toplam_siparis_tutari
FROM Siparisler;

-- Her müşterinin toplam harcamasını bulalım

SELECT Musteriler.MusteriID, Musteriler.Isim, Musteriler.Soyisim, SUM(Siparisler.ToplamTutar) AS Toplam_Harcama
FROM Siparisler
JOIN Musteriler ON Siparisler.MusteriID = Musteriler.MusteriID
GROUP BY Musteriler.MusteriID
ORDER BY Toplam_Harcama DESC;

-- AVG -> Beklenen Değer --> Aritmetik Ortalama --> Ortalama --> Tüm değeri topla / kaç tane değer var
-- Ürünlerin ortalama fiyatını bulalım

SELECT AVG(Fiyat) As OrtalamaFiyat
FROM Urunler;

-- Her kategorideki ürünlerin ortalam fiyatını bulun

SELECT KategoriID, AVG(Fiyat) AS Ortalama_Fiyatı
FROM Urunler
GROUP BY KategoriID;

-- MAX - MIN : En büyük değer, En küçük değer

-- En yüksek fiyatlı ürünü bulalım

SELECT MAX(Fiyat) as max_fiyat
FROM Urunler;

-- Her kategorideki en yüksek fiyatlı ürünü bulalım

SELECT KategoriID, MAX(Fiyat) AS Max_Fiyatlar
FROM Urunler
GROUP BY KategoriID;

-- MIN

-- En düşük fiyatlı ürünü bulalım
SELECT MIN(Fiyat) as max_fiyat
FROM Urunler;

-- Her kategorideki en düşük fiyatlı ürünü bulalım
SELECT KategoriID, MIN(Fiyat) AS Min_Fiyatlar
FROM Urunler
GROUP BY KategoriID;


-- GROUP BY: Verilerimizi Gruplandırmamızı sağlıyor. 

--Şehir bazında Müşteri Sayılarını bulalım

SELECT Sehir, COUNT(*) as musteri_sayisi
FROM Musteriler
GROUP BY sehir;


-- HAVING : WHERE'e benzer bir ifadedir. GROUP BY ile birlikte kullanıldığında gruplar üzerinde filtreleme işlem yapar.

-- HEr kategorideki ort. fiyatı 194 TL'den yüksek olan kategorileri bulalım

SELECT KategoriID, AVG(Fiyat) AS Ort_Fiyat
FROM Urunler
GROUP BY KategoriID
HAVING AVG(Fiyat) > 194.00;


-- JOIN 
-- Veritabanında ilişkili tabloları birleştirmek için kullanılır. 
-- INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN

-- INNER JOIN
-- İki tabloyu ortak sütunlarına göre birleştirir ve eşleşen kayıtları döndürür.

-- Müşteriler ve Siparişler Tablolarını birleştirerek her müşterinin siparişlerini bulalım

SELECT Musteriler.MusteriID, Musteriler.Isim, Musteriler.Soyisim, Siparisler.SiparisID, Siparisler.ToplamTutar
FROM Musteriler
INNER JOIN Siparisler ON Musteriler.MusteriID = Siparisler.MusteriID;

-- ÖDEV
-- Siparis Detayları ve Ürünler tablolarını birleştirin ve her sipraişte hangi ürünlerin olduğunu seçin.

-- LEFT JOIN
-- Sol tablodaki tüm kayıtları ve sağ tablodaki eşleşen kayıtları döndürür. Eşleşmeyen sağ tablodaki kayıtları NULL olarak yazar.

-- Tüm müşterileri ve vasa siparişlerini seçelim

SELECT Musteriler.MusteriID, Musteriler.Isim, Musteriler.Soyisim, Siparisler.SiparisID, Siparisler.ToplamTutar
FROM Musteriler
LEFT JOIN Siparisler ON Musteriler.MusteriID = Siparisler.MusteriID;


-- ÖDEV
-- Tüm ürünleri ve varsa sipariş detaylarını seçelim.
 

-- RIGHT JOIN 
-- Sağ tablodaki tüm kayıtları ve sol tablodaki eşleşen kayıtları döndürür. Eşleşmeyen sol tablodaki kayıtları NULL olarak yazar.

-- Tüm sipariş detaylarını ve varsa ürünlerini seçelim

SELECT SiparisDetaylari.SiparisDetayID, SiparisDetaylari.Miktar, Urunler.UrunID, Urunler.UrunAdi
FROM SiparisDetaylari
RIGHT JOIN Urunler ON SiparisDetaylari.UrunID = Urunler.UrunID;


-- FULL OUTER JOIN
-- Her iki tablodaki tüm kayıtları döndürür. Eşlemeyen kayıtlar için NULL değerler döndürür.

-- ÖDEV
-- Tüm müşterileri ve tüm siparişleri eşleştirin
SELECT
FROM
FULL OUTER JOIN  ON

-- ÖDEV
-- Tüm ürünleri ve tüm siparişleri eşleştirin


-- CASE

-- SQL'de koşullu mantık yürütmek ve verilerimizi belirli koşullara göre değiştirmek için kullanıyoruz.

-- Müşterilerin şehirlerine göre bölgesel olarak sınıflandıralım

SELECT MusteriID, Isim, Soyisim, Sehir,
	CASE Sehir
		WHEN 'Ankara' THEN 'İç Anadolu'
		WHEN 'İstanbul' THEN 'Marmara'
		WHEN 'İzmir' THEN 'Ege'
		WHEN 'Antalya' THEN 'Akdeniz'
		ELSE 'Diğer'
	END AS Bolge
FROM Musteriler;

-- Siparişlerin Toplam Tutarına göre bir indirim durumu hesaplayalım
SELECT SiparisID, MusteriID, toplamtutar,
	CASE
		WHEN toplamtutar >= 5000 THEN 'Büyük İndirim'
		WHEN toplamtutar >= 3000 THEN 'Orta İndirim'
		WHEN toplamtutar >= 500 THEN 'Küçük İndirim'
		ELSE 'İndirim Yok'
	END AS IndirimDurumu
FROM Siparisler;


-- ÖDEV
-- Sipariş Detayları ve ürünler tablosunu birleştirip ürün kategorilerine göre farklı vergilendirme oranlarını hesaplayalım

-- -> Elektronik 0.18
-- -> Aksesuar 0.08
-- -> Ofis Ekipmanı 0.10

SELECT
CASE
	WHEN


	ELSE
END
FROM
JOIN ON


-- Window Fonksiyonları 
-- SQL'de veri analizini daha esnek ve güçlü hale getiren fonksiyonlardır. 

-- ROW_NUMBER(): Bir başlar sonuna kadar durmadan gider, 1,...,n

-- Ürünlerin fiyatlarına göre sıralama yapalım
SELECT Urunler.UrunID, Urunler.UrunAdi, Urunler.Fiyat,
 ROW_NUMBER() OVER(ORDER BY Urunler.Fiyat DESC) AS FiyatSirasi
FROM Urunler;

-- RANK(): Başlar eğer aynı sayıyı görürse değerini atar, sonrasında eklemeli olarak devam eder. 1,2,3,4,5,6,6,8 veya 1,2,3,3,3,5 gibi. 

-- Ürünlerin fiyatlarına göre sıralama yapalım

SELECT Urunler.UrunID, Urunler.UrunAdi, Urunler.Fiyat,
 RANK() OVER(ORDER BY Urunler.Fiyat DESC) AS FiyatSirasi
FROM Urunler;


-- DENSE_RANK() Perfect Just Perfect. 1,2,3,4,5,6,6,7,8,9,10,10,11 gibi
SELECT Urunler.UrunID, Urunler.UrunAdi, Urunler.Fiyat,
 DENSE_RANK() OVER(ORDER BY Urunler.Fiyat DESC) AS FiyatSirasi
FROM Urunler;


-- NTILE() : Gruplara böler
SELECT Urunler.UrunID, Urunler.UrunAdi, Urunler.Fiyat,
 NTILE(5) OVER(ORDER BY Urunler.Fiyat DESC) AS FiyatSirasi
FROM Urunler;


-- LAG ve LEAD tekrarını bu örneklerden bir tanesini seçip deneyiniz.

-- Her müşterinin bir önceki siparişinin tarihini ve tutarını gösterelim
-- Her müşterinin bir sonraki siparişinin tarihini ve tutarını gösterelim


-- Ayrı Örnekler
-- SUM + OVER kullanılan örnek: -- Her müşterinin kümülatif toplam sipariş tutarını hesaplayalım
-- AVG + OVER kullanılan örnek: -- Her müşterinin kümülatif ortalama sipariş tutarını hesaplayalım











-- Window Functions







