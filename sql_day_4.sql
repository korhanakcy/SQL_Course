-- SQL DAY 4 

-- Window Fonksiyonları


-- Geçerli satırla bir şekilde ilişkili ola bir dizi satırın hesaplamasını yapar. 
-- Orjinal satır verilerini koruyarak karmaşık toplama işlemlerini gerçekleştirir.
-- Hareketli ort., Veri sıralamalar, Kümülatif Toplamlar vb. işlemleri verimli şekilde yapar.
-- Alt sorgulara veya join işlemlerine gerek kalmadan sorguları basitleştirir.


-- YAPISI

SELECT sütun1,
	window_funtion() OVER (
		PARTITION BY sütun2
		ORDER BY sütun3
	)
FROM table_name_1;

-- 1. ROW_NUMBER
-- Her bir satıra unique sıra numarası atıyor.
-- 1, 2, 3, 4, 5, 6, ...

-- Customer tablosundaki müşterinin soyadlarına göre sıralayalım

SELECT customer_id, first_name, last_name,
	ROW_NUMBER() OVER(ORDER BY last_name) AS row_num
FROM customer;

-- RANK 

-- Her bir satıra sıra numarası atar. Aynı değere sahip satılar aynı sıralama numarasını alır.


-- Customer tablosundaki müşterinin soyadlarına göre sıralayalım

SELECT customer_id, first_name, last_name,
	RANK() OVER(ORDER BY last_name) AS rank
FROM customer;


-- DENSE_RANK 
-- Her bir satıra sıra numarası atar. Aynı değere sahip satırlar aynı sıralama numarası alır  ve sonrakine atlanmadan sıralama numarası atanır.

-- Customer tablosundaki müşterinin soyadlarına göre sıralayalım

SELECT customer_id, first_name, last_name,
	DENSE_RANK() OVER(ORDER BY last_name) AS dense_rank
FROM customer;


--------------|---------------------------------------------------------------------------
-- Fonksiyon  | Farkı																	   |
--------------|---------------------------------------------------------------------------
-- ROW_NUMBER | Benzersiz sıra numarası verir											   |
-- RANK       | Aynı değere sahip satırları aynı sıraya koymak istediğimizde, Sayı atlar. 
-- DENSE_RANK | Rank ile aynı çalışır tek farkı sayı atlamaz.							   |
------------------------------------------------------------------------------------------




-- NTILE 
-- Veri setini belirtilen sayıda gruba böler ve her bir satıra bu gruptaki sayısı atar.

-- Customer örneği

SELECT customer_id, first_name, last_name,
	NTILE(4) OVER(ORDER BY last_name) as last_name_quartile
FROM customer;


-- LAG VE LEAD 

--  LAG, bir önceki satırı değerini döner, LEAD, belirtilen bir sonraki satırın değerini döner.


-- Rental tablosundaki her bir kiralama tarihi için bir önceki ve bir soraki kiralama tarihini döndüren kodu yazalım

SELECT rental_id, rental_date,
	LAG(rental_date, 1) OVER (ORDER BY rental_date) AS prev_rental,
	LEAD(rental_date, 1) OVER (ORDER BY rental_date) AS next_rental
FROM rental;


-- CUME_DIST, PERCENT_RANK()

-- CUME_DIST, geçerli satırdan küçük veya eşit olan satırların oranını döner.
-- PERCENT_RANK(), geçerli satırın yüzdelik sıralamasını döner.


-- rental tablosundan her bir kiralama tarihi için kümülatif dağılım ve yüzdelik sıralamayı bulalım.


SELECT rental_id,
	CUME_DIST() OVER(ORDER BY rental_id) AS cume_dist
FROM rental;

SELECT rental_id,
	PERCENT_RANK() OVER(ORDER BY rental_id) AS cume_dist
FROM rental;


-- Kesikli rassal değişkenimiz varsa kullanın. Aksi de kullanılabilir ama anlamlı olmaz.


-- FIRST_VALUE and LAST_VALUE

-- FIRST_value ilk değeri döner, last value son değeri döner.
-- Belirli bir sıralama içindeki ilk veya son değeri almak için

-- Her müşteri için ilk ve son kiralama tarihini getirelim.

SELECT customer_id, rental_date,
	FIRST_VALUE(rental_date) OVER(PARTITION BY customer_id ORDER BY rental_date) AS first_rental_date,
	LAST_VALUE(rental_date) OVER(PARTITION BY customer_id ORDER BY rental_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_rental_date   
FROM rental;


-- NTH_VALUE 
-- N. değeri görmek istediğimde kullanırım.

-- Her müşterinin 3. kiralama tarihini getirelim.

SELECT customer_id,
	NTH_VALUE(rental_date, 3) OVER( PARTITION BY customer_id ORDER BY rental_date) AS third_rental
FROM rental;


-- Unique customer_id output

SELECT DISTINCT ON (customer_id) customer_id,
       NTH_VALUE(rental_date, 3) OVER (PARTITION BY customer_id ORDER BY rental_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_rental
FROM rental
ORDER BY customer_id, rental_date;

-- ROW_NUMBER, RANK, DENSE_RANK kullanarak last_name'e göre numaralandıralım

SELECT customer_id, first_name, last_name,
	ROW_NUMBER() OVER(ORDER BY first_name) AS row_num,
	RANK() OVER(ORDER BY first_name) AS rank_num,
	DENSE_RANK() OVER(ORDER BY first_name) AS dense_rank_num
FROM customer;



-- FULL Text Search (FTS) (SQL'in CTRL - F'İ)

-- Veritabanı tablolarında metin aramaları yapmyı kolaştıran bir özelliktir. Lıke sorgularının ötesine geçer ve metin içinde
-- anlamlı ve aktif ve daha performanslı bir arama yapmamızı sağlıyor.

-- Döküman Yönetim Sistemleri: Belge içeriğinde anahtar kelime arama
-- E ticaret Sitesi : Ürün açıklamarında arama


-- tsvector: Metni indekslemek için kullanıyoruz.
-- tsquery: Arama sorgularını ifade eder.
-- to_tsvector: Metni 'tsvector' formatına dönüştürür.
-- to_tsquery: Arama terimlerini 'tsquery' formatına dönüştürür.
-- @@ : tsvector ve tsquery'leri karşılaştırır.


-- 1. Metni tsvector formatına nasıl dönüştürürüm?

SELECT to_tsvector('english', 'The quick brown foc jumps over the lazy dog');

-- NLP(Natural Language Process)
-- Stopword: .,!?, 'The','and', 'a', 'an'.

SELECT to_tsvector('turkish', 'Bu bir denemedir. Türkçe dili mevcut mu? Kızılcıklar oldu mu selelere doldu mu');

SELECT to_tsvector('german', 'Ich bin Korhan. Bütte und du vier fünf');

SELECT to_tsvector ('spanish', 'es un clase interasante y muy bonita');

SELECT to_tsvector('french', 'Je mappelle Korhan, Du tappele Nazlı');

SELECT to_tsvector('italian', 'Le chanta mi cantare, solo italiaona');

SELECT to_tsvector('english', 'When I was walking to Park. I saw a man who is my friend. I went');


-- to_tsquery örneği

SELECT to_tsquery('english', 'quick & fox & is & running & away & from & cats');

SELECT to_tsquery('turkish', 'bu & bir & denemedir');


-- @@ : BOLEAN type -> 1,0 veya T,F

SELECT to_tsvector('english', 'The quick brown fox jumps over the lazy dog') @@
to_tsquery('english', 'quick & fox & over & dog')


SELECT to_tsvector('english', 'The quick brown fox jumps over the lazy dog') @@
to_tsquery('english', 'quick & fox & over & dog & cat')

-- || : iki sütunu birleştirmek istiyorsam, kullanıcam.

ALTER TABLE film ADD COLUMN tsv tsvector;
UPDATE film SET tsv = to_tsvector('english', title ||''|| description);
CREATE INDEX idx_ft_film_tsv ON film USING gin(tsv);



-- Film açıklamalarında 'action', 'drama' kelimelerini arayalım

SELECT film_id, title, description
FROM film
WHERE tsv @@ to_tsquery('english', 'action & drama');

SELECT film_id, title, description
FROM film
WHERE tsv @@ to_tsquery('english', 'documentary & robot');

-- Arama sonuçlarında istediğimiz kelimeleri vurgulayalım bold olarak.

SELECT film_id, title, ts_headline(description, to_tsquery('english', 'documentary  & robot')) AS highlighted_description
FROM film
WHERE tsv @@ to_tsquery('english', 'documentary  & robot');

-- Arama sonuçlarını alaka düzeyine göre sıralıyoruz.

SELECT film_id, title, description, ts_rank(tsv, to_tsquery('english', 'action & drama')) AS rank
FROM film
WHERE tsv @@ to_tsquery('english', 'action & drama')
ORDER BY rank DESC;

SELECT film_id, title, description, ts_rank(tsv, to_tsquery('english', 'shark')) AS rank
FROM film
WHERE tsv @@ to_tsquery('english', 'shark')
ORDER BY rank DESC;








































