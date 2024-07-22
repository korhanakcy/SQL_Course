-- DATE FUNCTIONS

-- Zaman ibari barındıran veri tiplerinde uygulanır. Tarih ve Zaman verilerini manipüle etmemizi, dönüştürmemizi ve karşılaştırmamızı sağlar.

-- İki tarih arasındaki farkı hesaplamak
-- Tarihe belirli bir süre ekleyip çıkartıcaz
-- BElirli bir tarihin yıl ay veya gün gibi bileşenleri elde etmek

-- 1. CURRENCT_DATE ve CURRENT_TIMESTAMP

-- Şuanki tarihi ve zamanı döndürecek.
-- CURRENCT_DATE -> sadece tarihi döndürür.
-- CURRENT_TIMESTAMPT -> hem tarihi hemde de zamanı döndürür.

SELECT CURRENT_DATE;

SELECT CURRENT_TIMESTAMP;

SELECT NOW();

-- 2. AGE

--  İki tarih arasındaki farkı yıllar aylar ve günler cinsinde dönüştürüyor.

SELECT AGE('2024-07-18', '2000-01-01');

SELECT AGE('2000-01-01', '2024-07-18');

-- İlk tarih ikinci tarihten büyük olmalıdır, öbür türlü negatif sonuç elde ederiz.


-- 3. DATE_PART

-- Tarihin belirli bir bileşenini döndürür. (yıl, ay, gün, saat, dk, sn)
-- Parametre olarak tarih bileşenlerini ('year', 'month', 'day', 'minute', 'second').

SELECT DATE_PART('year', '2024-07-18'::date);

-- ::date -> değeri date cinsine çevirir.

SELECT DATE_PART('month', '2024-07-18'::date);

SELECT DATE_PART('day', '2024-07-18'::date);

-- 4. DATE_TRUNC

-- Tarihte belirli bir yuvarlama yapar. ROUND() -> ROUND(6.7) = 7
-- Parametre olarak 'year', 'month'

SELECT DATE_TRUNC('month', '2024-07-18'::date); -- "2024-07-01 00:00:00+03"

SELECT DATE_TRUNC('year', '2024-07-18'::timestamp); -- "2024-01-01 00:00:00"

-- 5. EXTRACT 

-- EXTRACT, DATE_PART benzer şekilde çalışıyor. 
-- Parametleri nelerdir? Ben EXTRACT ve benim parametrelerim ('year', 'month', 'day', 'hour', 'minute', 'second') 
-- Timestamp değeri alır.

SELECT EXTRACT(year FROM '2024-07-18'::date);

SELECT EXTRACT(month FROM '2024-07-18'::timestamp);

SELECT EXTRACT(day FROM '2024-07-18'::timestamp);

SELECT EXTRACT(hour FROM '2024-07-18 10:07:00'::timestamp) as now_the_hour_is;

SELECT EXTRACT(minute FROM '2024-07-18 10:07:00'::timestamp);

SELECT EXTRACT(second FROM '2024-07-18 10:07:00'::timestamp);


-- 6. TO_CHAR

-- Tarih veya zaman değelerini belirli bir formatta döndürür
-- Format belirleyicileri kullanılarak özelleştirilebilir. 

SELECT TO_CHAR('2024-07-18'::timestamp, 'YYYY-MM-DD');

SELECT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS'); 

SELECT TO_CHAR(CURRENT_TIMESTAMP, 'Day, DD Month YYYY'); 

SELECT TO_CHAR('2000-01-01'::date, 'Day, DD Month YYYY'); 

-- 7. INTERVAL

-- Tarihe belirli bir süre eklemek veya çıkarmak için kullanılır.
-- Süreler: yıl ay gün saat dakika saniye olarak belirtilebilir.

SELECT (CURRENT_DATE + INTERVAL '1 month');

SELECT (CURRENT_DATE - INTERVAL '1 year');

SELECT CURRENT_TIMESTAMP + INTERVAL '2 hours';

SELECT CURRENT_TIMESTAMP - INTERVAL '50 minutes';

SELECT CURRENT_TIMESTAMP + INTERVAL '10 minutes' as Ders_Devam_Saati;

SELECT CURRENT_TIMESTAMP



-------------------- DVD RENTAL ÖRNEKLERİ ---------------------------------


SELECT *
from customer;

-- Müşterilerin oluşturulma tarihlerine göre hesaplanmış süresini bulalım.

SELECT customer_id, first_name, last_name, create_date, AGE(CURRENT_DATE, create_date) as account_age
FROM customer;

-- Customer tablosundaki last_update yıllarınını listeleyelim.

SELECT customer_id, first_name, last_name, create_date, DATE_PART('year', last_update) AS last_updated_year
FROM customer;


-- Film kiralama tablosundaki kiralama tarihleirini ay bazında gruplandırarak kiralama sayısı bulalım.

SELECT DATE_TRUNC('month', rental_date) as month, COUNT(*) as rental_count
FROM rental
GROUP BY month
ORDER BY rental_count DESC;


-- 2005 - 2006 yılları arasıda 30 günlük süre içinde yapılan kiralamaları, haftalık gruplar halinde listelieiyp her hafta için toplam kiralama sayısını
-- görelim.


SELECT DATE_TRUNC('week', rental_date) AS week_start, COUNT(*) AS rental_count
FROM rental
WHERE rental_date > '2005-01-30'::date - INTERVAL '30 days' AND rental_date < '2006-01-30'::date
GROUP BY week_start
ORDER BY week_start;


-- Film kiralama tablosundan her bir kiralama süresini gün cinsinden hesaplayalım,

SELECT rental_id, rental_date, return_date, AGE(return_date, rental_date) AS rental_duration
FROM rental
ORDER BY rental_duration ASC;





---------------------------------------------------------------------------------------------------------------

-- CASE FUNCTIONS

-- Sütun veya ifade üzerindeki koşullara bağlı olarak farklı değerler döndürmemizi sağlar. Temel olarak, IF ELSE mantığına sahiptir.
-- Veri manipülasyonu için kullanılır.

-- Verileri koşullara göre kategorize etmek için kullanırız. 

-- CASE 
--	WHEN durum1 THEN sonuc1
--	WHEN durum2 THEN sonuc2
--	ELSE sonucN
--END


-- CASE
--	WHEN yas < 18 THEN 0--
--	ELSE 1
-- END AS oy_kullanılabilirlik

-- Film kategorilerine göre film uzuluğunu sınıflandıralım.

SELECT * FROM film

SELECT title, length,
	CASE
		WHEN length < 60 THEN 'Short'
		WHEN length BETWEEN 60 AND 120 THEN 'Medium'
		ELSE 'Long'
	END AS length_category
FROM film;



-- Müşteri Kiralama sayısına göre Müşterinin Statüsünü belirleyelim

SELECT customer_id, first_name, last_name, COUNT(rental_id) AS rental_count,
	CASE
		WHEN COUNT(rental_id) > 40 THEN 'VIP'
		WHEN COUNT(rental_id) BETWEEN 20 and 40 THEN 'Regular'
		ELSE 'Nothing else matter'
	END AS customer_status
FROM customer
JOIN rental USING (customer_id)
GROUP BY customer_id, first_name, last_name;


--- CASE'lerin kullanıldığı durumda WHERE komutunuda kullanmak istersek subquery oluşturmamız gerekir.
-- Subquery ile biz GEÇİCİ tablo oluşturmuş ve bu sütunları almış oluruz.
-- CASE ifadesiyle  WHERE ifadesi doğrudan birlikte çalışmaz.

SELECT *
FROM(SELECT customer_id, first_name, last_name, COUNT(rental_id) AS rental_count,
	CASE
		WHEN COUNT(rental_id) > 40 THEN 'VIP'
		WHEN COUNT(rental_id) BETWEEN 20 and 40 THEN 'Regular'
		ELSE 'Nothing else matter'
	END AS customer_status
FROM customer
JOIN rental USING (customer_id)
GROUP BY customer_id, first_name, last_name) AS subquery
WHERE customer_status = 'VIP';

-- Film kategorileri ve Kiralam Sürelerine göre İndirim

SELECT title, rental_duration, category.name AS category,
	CASE
		WHEN category.name = 'Action' AND rental_duration > 5 THEN '%10 Discount'
		WHEN category.name = 'Comedy' AND rental_duration > 3 THEN '%5 Discount'
		ELSE '%0 Discount'
	END AS discount
FROM film
JOIN film_category USING(film_id)
JOIN category USING (category_id);


-- CASE'lerle oluşturduğum sütunumu kalıcı hale getiricem ama nasıl?

-- 1 Yeni sütun ekle
-- 2 Yeni sütunu güncelle
-- 3 Done

SELECT *
FROM film;

ALTER TABLE film ADD COLUMN length_category VARCHAR(10);

UPDATE film
	SET length_category =
		CASE 
			WHEN length < 60 THEN 'Short'
			WHEN length BETWEEN 60 AND 120 THEN 'Medium'
			ELSE 'Long'
		END;


-- PERFORMANS OPTİMİZASYONU

-- CASE ifadelerinin perfomansı büyük veri kümelerinde önemlidir. Bu yüzden performans optimizsayonu için ne yapılabilir?

-- 1. Index Kullanımı: Sorgularda kullanılan sütunlara uygun indekseler eklemek bizim sorgu performansını arttırabilir.
-- 2. Koşulları Sorlamak: CASE ifadelerinde en sık karşılaşılan koşulları önce yerleştirmek bu şekilde biz daha hızlı çalışmasına yardımcı oluyoruz.


-- Örnek : E ticaret sitesinde DATA ENGINEER'siniz ve E ticaret sitesindeki ürünlerin stok durumuna göre etiketlemek istiyorsunuz.

SELECT product_name, stock_quantity
	CASE 
		WHEN stock_quantity = 0 THEN 'Out of Stock'
		WHEN stock_quantity < 5 THEN 'Low Stock'
		ELSE 'In stock'
	END AS stock_status
FROM product;





















































