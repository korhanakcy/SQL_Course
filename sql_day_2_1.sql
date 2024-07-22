CREATE TABLE personel
(
p_no SERIAL PRIMARY KEY,
p_ad VARCHAR(25) NOT NULL, 
p_soyad VARCHAR(30) NOT NULL,
cinsiyet CHAR(1) NOT NULL,
dogum_tarihi DATE,
dogum_yeri VARCHAR(20),
ise_baslama_tarihi date,
birim VARCHAR(25),
unvan VARCHAR(25),
calisma_saati INT,
maas INT,
prim INT
);


INSERT INTO personel(p_ad,p_soyad,cinsiyet,dogum_tarihi,dogum_yeri,ise_baslama_tarihi,birim,unvan,calisma_saati,maas,prim)
VALUES
('Serkan','EKİNCİ','E','1985.03.25','Adana','2002.03.01','KALİTE','MÜHENDİS',35,2500,350),
('Semih Furkan','TURHAN','E','1980.04.15','Adana','2002.05.03','İDARİ','İK UZMANI',30,2800,250),
('Ekin Emir','SAKARYA','E','1983.03.23','İstanbul','2005.05.12','İDARİ','TEKNİSYEN',30,3000,250),
('Muhammet Ali','ÇOLAK','E','1982.05.05','İstanbul','2005.06.17','ARGE','TEKNİSYEN',40,2800,350),
('Kübra','ÇITAK','K','1987.12.05','İstanbul','2000.01.12','İDARİ','MÜHENDİS',30,4500,500),
('Kübra GÜL','ESMER','K','1982.10.22','Ankara',	'1998.05.07','KALİTE','İK UZMANI',35,4000,250),
('Emirhan','TANAR','E','1983.02.28','İstanbul','1997.05.07','KALİTE','İK UZMANI',35,5200,450),
('Enes','YANIK','E','1975.05.07','İzmir','2010.07.17','İDARİ','İK UZMANI',45,4500,450),
('Ahmet Turan','ACI','E','1974.05.01','Konya','2000.08.18','ARGE','İK UZMANI',40,4200,400),
('Muhammet Yasin','TAŞ','E','1974.07.02','Adana','1995.09.05','TEKNİK','MÜHENDİS',40,4400,400),
('Fadıl Ahmet','CAN','E','1976.09.18','Konya','1998.10.12','İDARİ','İK UZMANI',45,3250,450),
('Yusuf Alperen','ALBAYRAK','E','1976.08.19','Ankara','2000.11.25','KALİTE','İK UZMANI',30,5200,250),
('Hasan Furkan','HASKIRIŞ','E','1978.09.20','İstanbul','1999.10.27','KALİTE','İK UZMANI',35,4200,350),
('Emine Zuhal','UYSAL','K','1985.08.04','İzmir','2000.05.27','KALİTE','İK UZMANI',30,2500,100),
('Görkem Taha','UYSAL','E','1990.12.01','İzmir','2000.03.06','İDARİ','MÜHENDİS',30,2000,150),
('Lara','UYSAL','K','1982.02.15','Ankara','1995.05.12','TEKNİK','TEKNİSYEN',30,4800,150),
('Uğur','BUZDAĞ','E','1980.10.30','İstanbul','2001.08.10','KALİTE','İK UZMANI',40,4800,400),
('İlyas','IŞILDAK','E','1980.10.28','Ankara','2001.09.28','TEKNİK','MÜHENDİS',30,2200,300),
('Bayram','ÇAKIR','E','1981.11.19','İzmir','2001.07.30','TEKNİK','TEKNİSYEN',30,2700,300),
('Deniz','KÖSEDAĞ','E','1981.12.20','İzmir','2002.12.20','ARGE','İK UZMANI',30,2900,350),
('Efe Can','ÇAPANOĞLU','E','1982.02.20','İstanbul','1998.05.25','ARGE','TEKNİSYEN',30,4800,200),
('Serdar Engin','BOZOKLU','E','1983.07.21','İstanbul','2005.09.05','KALİTE','İK UZMANI',30,3000,200),
('Berat','DUMAN','E','1975.06.13','İstanbul','2005.03.05','KALİTE','TEKNİSYEN',30,2800,200),
('Bedirhan','ŞİRİN','E','1978.04.02','İzmir','1998.04.04','İDARİ','İK UZMANI',35,3300,250),
('Emre','ERTÜZÜN','E','1980.07.03','Bilecik','2002.07.18','TEKNİK','TEKNİSYEN',35,3100,300),
('Fatih','GÖKÇE','E','1975.06.18','İstanbul','2002.03.25','TEKNİK','TEKNİSYEN',35,3100,450),
('Dilek','CANİŞ','K','1978.03.03','İstanbul','2005.08.13','KALİTE','TEKNİSYEN',40,2500,500),
('Mehmet','GEYLAN','E','1974.01.07','Adana','2007.08.17','TEKNİK','TEKNİSYEN',40,2200,450),
('Hüseyin','MAHDUM','E','1987.11.21','Ankara','2005.12.11','TEKNİK','TEKNİSYEN',35,2600,350),
('Muhammed Ali','MELAYİM','E','1987.12.22','İstanbul','2007.08.13','KALİTE','MÜHENDİS',35,3100,400);

-----------------------

--Aggregates Function

-- COUNT, SUM, AVG, MIN, MAX

-- Veri Özetleme, Raporlama, Veri Analizi için kullanılır.

SELECT *
FROM personel;


-- MAX FONKSİYONU
-- Belirli sütunumuzda en büyük değer olacak.

SELECT MAX(maas)
FROM personel;

-- AS komutu adlandırma için kullanıcaz.

SELECT MAX(maas) AS en_yuksek_maas
FROM personel;


-- birimi İDARİ olan en yüksek maaş nedir? (İdari_max_maas olarak adlandır.)

SELECT MAX(maas) AS idari_max_maas
FROM personel
WHERE birim = 'İDARİ';

-- Birimi İDARİ ve unvanı'da İK UZMANI olan kişilerin aldığı Max maaş nedir? (AS idari_ik_max_maas)

SELECT MAX(maas) AS idari_ik_max_maas
FROM personel 
WHERE birim = 'İDARİ' AND unvan = 'İK UZMANI';


SELECT MAX(calisma_saati) FILTER (WHERE cinsiyet = 'E') AS max_calisma_E,	MAX(calisma_saati) FILTER (WHERE cinsiyet = 'K') AS max_calisma_K
FROM personel;

SELECT MAX(calisma_saati) FILTER (WHERE cinsiyet = 'E') AS max_calisma_E,	MAX(calisma_saati) FILTER (WHERE cinsiyet = 'K') AS max_calisma_K
FROM personel
WHERE birim = 'İDARİ';



-- MIN : BElirli sütundaki en küçük değeri döndürür.
-- MIN(sütun_adı)

SELECT MIN(MAAS) as min_maas
FROM personel

-- En az çalışan kişi kaç saat çalışıyor?

SELECT MIN(calisma_saati) AS min_calısma_saati
FROM personel;

-- Cinsiyetlere göre çalışma saatlerinin minimumlarını bulalım.

SELECT MIN(calisma_saati) AS erkek_min_calisma
FROM personel
WHERE cinsiyet = 'E';


SELECT MIN(calisma_saati) AS kadın_min_calisma
FROM personel
WHERE cinsiyet = 'K';


SELECT MIN(calisma_saati) FILTER (WHERE cinsiyet = 'E') AS min_calisma_E,	MIN(calisma_saati) FILTER (WHERE cinsiyet = 'K') AS min_calisma_K
FROM personel;

SELECT MIN(calisma_saati) FILTER (WHERE cinsiyet = 'E') AS min_calisma_E,	MIN(calisma_saati) FILTER (WHERE cinsiyet = 'K') AS min_calisma_K
FROM personel	
WHERE birim = 'İDARİ';


-- AVG() : belirli bir sütundaki saıysal değerlerin ortalamasını verir. 
-- Namı diğer ORTALAMA.

SELECT AVG(maas)
FROM personel;

-- ARGE için ortalama maaş ne kadardır?

SELECT AVG(maas) as ort_arge
FROM personel
WHERE birim = 'ARGE';

SELECT AVG(maas) as ort_idari
FROM personel
WHERE birim = 'İDARİ';

SELECT AVG(maas) as ort_teknik
FROM personel
WHERE birim = 'TEKNİK';

SELECT AVG(maas) as ort_kalite
FROM personel
WHERE birim = 'KALİTE';



-- SUM: Belirbir bir sütundaki sayısal değerleri toplamını döndürüyor. 
-- Finansal ve Miktar bilgilerini toplarken

SELECT SUM(maas) as total_maas
FROM personel;

SELECT SUM(maas) as total_maas_kalite
FROM personel
WHERE birim = 'KALİTE';



SELECT DISTINCT dogum_yeri
FROM personel;

-- Ayrı ayrı Konya, Bilecik için total maaş/prim ne kadar?


SELECT SUM(maas) AS total_konya_maas
FROM personel
WHERE dogum_yeri = 'Konya';

SELECT SUM(maas) AS total_konya_maas
FROM personel
WHERE dogum_yeri = 'Bilecik';

	
SELECT SUM(maas) AS total_konya_maas
FROM personel
WHERE dogum_yeri = 'Konya' AND birim = 'ARGE';

-- COUNT : Kaç tane var? 

-- Benim kaç çalışanım var?

SELECT COUNT(*) AS Personel_Sayısı
FROM personel;

-- Kadın çalışan Sayısı?

SELECT COUNT(*) as kadin_personel
FROM personel
WHERE cinsiyet = 'K';

SELECT COUNT(*) as erkek_personel
FROM personel
WHERE cinsiyet = 'E';


-- 3500 TL'den yüksek maaşı olan ve cinsiyeti Erkek olan kaç kişi var?

SELECT COUNT(*)
FROM personel
WHERE maas > 3500 and cinsiyet = 'E';


-- Personel sayısı kaç tane, Toplam maaş, Ortalama maaş yanyana

SELECT COUNT(*) as Personel_Sayısı, SUM(maas) as toplam_maas, AVG(maas) as ort_maas
FROM personel;


-- En yüksek maaş, En düşük maaş, Ortalama maaş ama cinsiyeti Erkek olanlar için.

SELECT MAX(maas) as max_maas_e , MIN(maas) min_maas_e, AVG(maas) ort_maas_e
FROM personel
WHERE cinsiyet = 'E'

-- En yüksek maaş, En düşük maaş, Ortalama maaş ama maaşı 2000'den büyük cinsiyeti Erkek olanlar için.
	
select max(maas) as enyuksekmaas,min(maas) as enazmaas,avg(maas) as ortmaas 
from personel 
where maas > 2000 and cinsiyet = 'E';
	
-- En yüksek maaş, En düşük maaş, Ortalama maaş ama birimi 'İDARİ' olanlar için.

SELECT MAX(maas) as max_maaş_idari,MIN(maas) as min_maaş_idari, AVG(maas) as ortlama_maas_idari
FROM personel
WHERE birim='İDARİ';


-- GROUP_BY : Seçtiğimiz sütun için gruplama yapar. 

SELECT birim, AVG(maas) as ort_maas, AVG(prim) as ort_prim
FROM personel
GROUP BY birim;

-- cinsiyete göre max, toplam maaşa bakalım 

SELECT cinsiyet, MAX(maas) as max_maas, SUM(maas) as total_maas
FROM personel
GROUP BY cinsiyet;



-- 1. Prim toplamı birimlere göre
-- 2. Çalışan sayısı birimlere göre
-- 3. prim, çalışan, ort maaş birimlere göre
-- 4. Unvana göre en yüksek maaş
-- 5. Her bir birim avg çalışma saati, avg maaş
-- 6. Birime ve unvana göre ort çalışma saati ve toplam maaş


SELECT *
FROM personel;
