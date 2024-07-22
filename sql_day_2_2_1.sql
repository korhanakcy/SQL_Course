CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1001, 'Ahmet Yılmaz', 'İstanbul', 'Türkiye');

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1002, 'Ayşe Demir', 'Ankara', 'Türkiye');

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1003, 'Mehmet Kaya', 'İzmir', 'Türkiye');

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1004, 'Fatma Öztürk', 'Bursa', 'Türkiye');

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1005, 'Ali Can', 'Adana', 'Türkiye');

INSERT INTO customers (customer_id, customer_name, city, country)
VALUES (1006, 'Zeynep Gül', 'Antalya', 'Türkiye');


CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  order_date DATE,
  customer_id INT REFERENCES customers(customer_id),
  total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, order_date, customer_id, total_amount)
VALUES (1, '2023-04-01', 1001, 150.00);

INSERT INTO orders (order_id, order_date, customer_id, total_amount)
VALUES (2, '2023-04-05', 1002, 200.00);

INSERT INTO orders (order_id, order_date, customer_id, total_amount)
VALUES (3, '2023-04-10', 1003, 75.50);

-- Primary Key (Birincil Anahtar) :
-- Bir veri tablosunda yer alana her satır için bir tanımlayıcı görevi görür. Her satır için eşsizdir. 
-- Satırlara ait değerlerin karışmaması adına bu alana ait bilginin tekrarlanmaması gerekir. Temel işlevi verilen hangi satıra dizileceğine karar vermesidir.
-- Çoğunlula tek bir alan (id, user_id, username, email) olarak kullanılsa da birden falza alanın birleşimiyle de oluşabilir. 
-- Primary key boş değer alamaz ve null değeri alamaz. İlişkisel veri tabanlarında mutlaka primary key olmalıdır. 


-- Foreign Key:
-- İkincil anahtar olarak da adlanadırılır. Bir veri tablosuna girilebilecek değerleri başka bir veri tablosundaki alanlarla ilişkilendirmeye yarar.
-- Özetle, başka bir tablonun birincil anaharının bir diğer tablo içersinde yer almasıdır. 
-- Çoğunlukla bir ana tablo(parent) ile alt tablonun (child) ilişkilendirimesinde kullanılır.
-- Bu sayede olası veri tekrarlarının önüne geçilebilir.



-- Candidate Key, Alternate Key, Super Key, Compound Key, Composite Key, Surrogate Key 



-- JOIN, Genellikle Primary Key ve Foreign Key ile gerçekleştirilir. JOIN işlemi iki temel JOIN ve ON. Join işkeminde SELECT ile beritlen tabloyla 
-- Birleştirmek istediğimiz tablonun adını JOIN anahtar kelimesinden sonra ifade edebiliriz. ON anahatar kelimesi ile birlikte iki tablonun sütundalarını
-- baz alarak birleştirebiliriz.


-- SELECT *
-- FROM tablo1
-- JOIN tablo2 ON tablo1.sütun1 = tablo2.sütun2;

-- id <- tablo1.sütun1, customer_id <- tablo2.sütun2, olarak düşünülebilir.



-- INNER JOIN: Birincil tablo ve eşleşen kayıtları olan diğer tablo arasında birleştirme yapar. INNER JOIN, her iki tablodan yanlızca eşleşen kayıtları getirir.

SELECT * 
FROM orders;

SELECT * 
FROM customers;

SELECT *
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id;

-- LEFT JOIN: birincil tablodaki tüm kayıtları ve eşleşen kayıtları olan diğer tablodaki kayıtları birleştirir. Eşleşmeyen kayıtlar NULL olarak adlandırılır.
--  SAĞ tarafa atar.

SELECT *
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id;



-- RIGHT JOIN : birincil tablodaki tüm kayıtları ve eşleşen kayıtları olan diğer tablodaki kayıtları birleştirir.Eşleşmeyen kayıtlar NULL olarak adlandırılır.

SELECT *
FROM customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id;


SELECT *
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id;

-- FULL OUTER JOIN: LEFT ve RIGHT JOIN birleşmesi gibi davranır. 

SELECT *
FROM customers
FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id;

-- WHERE ile JOIN yapabilir miyim?
-- Eski bir JOIN yöntemidir.

SELECT *
FROM orders, customers
WHERE orders.customer_id = customers.customer_id;


--------------















