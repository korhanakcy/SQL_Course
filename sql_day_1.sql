-- SELECT FROM WHERE LIMIT ORDER BY , AND OR IN NOT 

-- first_name, last_name from actor ve ismimleri "Nick" "Ed" "Jennifer" 


SELECT first_name, last_name
FROM actor
WHERE first_name IN ('Nick', 'Ed', 'Jennifer')

-- first_name, last_name from actor ve ismimleri Taylor, Brad, Leonardo


SELECT *
FROM address;


-- address, disctrict, phone, phone  Büyükten Küçüğe from address

SELECT address, district, phone
FROM address
ORDER BY phone DESC;


-- address, district, phone, address Küçükten Büyüğe

SELECT address, district, phone
FROM address
ORDER BY address ASC;

-- district'i postal code, district = 'England' from address

SELECT district, postal_code
FROM address
WHERE district = 'England';


-- SELECT DISTINCT ile, district distinct değerine sahibim ve onlar neler?

SELECT DISTINCT district
FROM address;

-- district'e göre a'dan z'ye sırala

SELECT DISTINCT district
FROM address
ORDER BY district ASC;


-- district, phone, California için istiyorum ve phone küçükten büyüğe ve ilk 2 değeri istiyorum.
 
SELECT district, phone
FROM address
WHERE district = 'California'
ORDER BY phone ASC
LIMIT(2);


