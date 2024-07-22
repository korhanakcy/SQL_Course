-- SQL DAY 5 -22.07.2024-

-- USER DEFİNED FUNCTIONS: Belirli bir işlemi gerçekleştirmek için kullanıcılar tarafından tanımlanan özel fonksiyonlardır.

-- 1. Fonksiyon tanımlama:

-- CREATE FUNCTION ibaresiyle başlar, Fonksiyonun parametreleri dönceği veri tipi ve içinde yapılacak işlemleri belirtir.

CREATE FUNCTION function_name(parameters)
RETURNS return_type AS $$
BEGIN
	-- fonksiyon tanımı
	RETURN value;
END;
$$ LANGUAGE language_name; -- plpgsql**, sql


-- Örnek: iki tam sayıyı toplayan fonksiyon yazalım.


CREATE FUNCTION add_numbers(a INTEGER, b INTEGER)
RETURNS INTEGER AS $$
BEGIN
	RETURN a+b;
END;
$$ LANGUAGE plpgsql;

SELECT add_numbers(5,3);


-- -, *, /

CREATE FUNCTION subtract_numbers(a INTEGER, b INTEGER)
RETURNS INTEGER AS $$
BEGIN
	RETURN a-b;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION multiply_numbers(a INTEGER, b INTEGER)
RETURNS INTEGER AS $$
BEGIN
	RETURN a*b;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION divide_numbers(a INTEGER, b INTEGER)
RETURNS NUMERIC AS $$
BEGIN
	IF b = 0 THEN
		RETURN NULL;
	ELSE
		RETURN a::NUMERIC/b::NUMERIC;
	END IF;
END;
$$ LANGUAGE plpgsql;


SELECT add_numbers(5,3) AS Toplam, subtract_numbers(5,3) AS Çıkarma, multiply_numbers(5,3) AS Çarpma, divide_numbers(5,3) AS Bölme;

SELECT add_numbers(1000,300) AS Toplam, subtract_numbers(555,312) AS Çıkarma, multiply_numbers(465,320) AS Çarpma, divide_numbers(1551,0) AS Bölme;

-- Fonksiyonlar farklı veri tiplerinde değerler dönebilir. INT, TEXT, BOOLEAN, TABLE vb.


-- Metni büyük harflerle yazan fonksiyon

CREATE FUNCTION to_uppercase(text_val TEXT)
RETURNS TEXT AS $$
BEGIN
	RETURN UPPER(text_val);
END;
$$ LANGUAGE plpgsql;

SELECT to_uppercase('capslock kullanmaya son!')


-- Verilen metnin uzunluğunu hesaplayan bir fonksiyon yazalım.

CREATE FUNCTION text_length(text_val TEXT)
RETURNS INTEGER AS $$
BEGIN
	RETURN LENGTH(text_val);
END;
$$ LANGUAGE plpgsql;

SELECT text_length('capslock kullanmaya son');

SELECT text_length('POSTGRESQL');


-- 3 Farklı tip fonksiyon çeşidimiz var. Bunlar, Scalar, Table, Trigger fonk. dır.

-- SCALAR FUNCTIONS (Skaler Fonksiyonlar)
-- Tek bir değer dönen fonksiyonlar. Bir veya daha fazla girdi alır ve tek bir çıktı üretir.

CREATE TABLE employees(
	employee_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	salary NUMERIC,
	birth_year INT
); 

INSERT INTO employees(first_name, last_name, salary, birth_year)
VALUES
('John', 'Doe', 50000, 2000),
('Jane', 'Smith', 60000, 1998),
('Alice', 'Johnson', 70000, 2002),
('Bob', 'Brown', 55000, 2001),
('Charlie', 'Davis', 75000, 1999);


SELECT * from employees;

-- Çalışanın tam adını döndüren fonksiyon:


CREATE FUNCTION get_full_name(emp_id INTEGER)
RETURNS TEXT AS $$
DECLARE 
	full_name TEXT;
BEGIN
	SELECT first_name||' '||last_name INTO full_name  
	FROM employees
	WHERE employee_id = emp_id;

	RETURN full_name;
END;
$$ LANGUAGE plpgsql;


SELECT get_full_name(1);

-- DROP FUNCTION get_full_name;

-- Çalışanlar kaç yaşındadır?

CREATE FUNCTION calculate_age(birth_year1 INT)
RETURNS INT AS $$
DECLARE current_year INT;
		age INT;
BEGIN
	current_year := EXTRACT(YEAR FROM CURRENT_DATE); --yyyy
	age := current_year-birth_year1;
RETURN age;
END;
$$ LANGUAGE plpgsql;

SELECT first_name, last_name, calculate_age(birth_year) AS age
FROM employees;


-- Çalışanlarımız yıllık ne kadar maaş alıyor?

CREATE FUNCTION calculate_annual_salary(monthly_salary NUMERIC)
RETURNS NUMERIC AS $$
BEGIN 
	RETURN monthly_salary * 12;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_annual_salary(100000);

SELECT first_name, last_name, salary, calculate_annual_salary(salary) AS annual_salary
FROM employees;

-- 2. Tablo Fonksiyonları
-- Birden fazla satır ve sütun içeren tablo döndüren fonksiyonlardır. Genellikle karmaşık sorguların sonuçlarını döndürmek için kullanılır.


CREATE TABLE projects(
	project_id SERIAL PRIMARY KEY,
	project_name TEXT,
	start_date DATE,
	end_date DATE
);

INSERT INTO projects(project_name, start_date, end_date) VALUES
('Project A', '2023-01-01', '2023-06-30'),
('Project B', '2023-02-01', '2023-07-30'),
('Project C', '2023-03-01', '2023-08-30'),
('Project D', '2023-04-01', '2023-09-30'),
('Project E', '2023-05-01', '2023-10-30');

-- Belirli bir tarih aralığında başlayan projeleri döndüren bir fonksiyon yazalım.

CREATE FUNCTION get_projects_by_date(p_start_date DATE, p_end_date DATE)
RETURNS TABLE(project_name TEXT, start_date DATE, end_date DATE) AS $$
BEGIN
	RETURN QUERY
	SELECT p.project_name, p.start_date, p.end_date
	FROM projects p 
	WHERE p.start_date >= p_start_date AND p.start_date <= p_end_date;
END;
$$ LANGUAGE plpgsql;

SELECT * 
FROM get_projects_by_date('2023-02-01','2023-04-30');


CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_name TEXT,
	order_date DATE,
	total_amount NUMERIC
);

INSERT INTO orders(customer_name, order_date, total_amount) VALUES
('John Doe', '2023-01-01', 100.00),
('Jane Smith', '2023-02-15', 200.00),
('Alice Johnson', '2023-03-10', 150.00),
('Bob Brown', '2023-04-05', 250.00),
('Charlie Davis', '2023-05-20', 300.00);

-- Belirli bir miktardan yüksek tutara sahip siparişleri döndüren fonksiyon yazalım.

CREATE FUNCTION get_large_orders(min_amount NUMERIC)
RETURNS TABLE(cus_name TEXT, order1_date DATE, total1_amount NUMERIC) AS $$
BEGIN
	RETURN QUERY
	SELECT customer_name, order_date, total_amount
	FROM orders
	WHERE total_amount > min_amount;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_large_orders(199.99);

-- 1. CREATE FUNCTION
-- 2. fonksiyon ismi parantez aç parametre ve parametrenin tipini yaz
-- 3. RETURNS kısmı eğer skalerse (yani tek bir değeri vermesini istiyorsam) tipini yazıyorum,
-- Eğer Table ise TABLE diyip Tablomun içinde bulunmasını istediğim sütunları yazıyorum) ve AS $$
-- 4. BEGIN yazarak ben fonksiyonumun girişini yapmış oluyorum. 
-- 5. RETURN QUERY : fonksiyonu her bir satır için döndüren kısım oluyor. (Table İçin)
-- 6. Fonksiyonun ana kısmı: Table için ben hangi değerleri kullanıcam ve çıktı olarak getirmek istiyorum. 
-- Ve hangi durumlar için istiyorum. 
-- 7. END; ile fonksiyonumu bitirdim
-- 8. Ve sonunda $$ LANGUAGE plpgsql;
-- 9. Sorgu için SELECT * FROM BİZİM_FONKSİYON(İSTENİLEN DEĞER);

-- Belirli bir tarih aralığında yapılan siparişleri döndüren fonksiyonu yazalım.

CREATE FUNCTION get_orders_by_date(start_date DATE, end_date DATE)
RETURNS TABLE(cust_name TEXT, order1_date DATE, total1_amount NUMERIC) AS $$
BEGIN
	RETURN QUERY
	SELECT customer_name, order_date, total_amount
	FROM orders
	WHERE order_date >= start_date AND order_date <= end_date;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_orders_by_date('2023-02-01','2023-04-30');









