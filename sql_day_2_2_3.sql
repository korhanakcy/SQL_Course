--Wildcard: Satır bazlı aramalarda kullanılır. İstenilen özelliğe sahip değeri bulmak için kullanıyoruz.
-- WHERE ve LIKE ile kullanılır. '%' 

-- WHERE kisi LIKE 'a%' -> 'a' ile başlayan tüm verileri bulur. (A)hmet
-- WHERE kisi LIKE '%a' -> 'a' ile biten bütün değerleri bulur. Saf(a)
-- WHERE kisi LIKE '%ap%' -> Değerlerin içinde 'ap' geçen değeleri bulur. K(ap)lan
-- WHERE kisi LIKE '_r&' -> İkinci harfi R olan değeleri bul. A(r)izona
-- WHERE kisi LIKE 'a_%_%' -> A ile başlayan en az 3 karakterli değeri bulur. (A)li
-- WHERE kisi LIKE 'a%o' -> a ile başlayıp o ile biten değerleri bulur. (A)l(o)


SELECT *
FROM actor;

-- A ile başlayan actorler
SELECT *
FROM actor
WHERE first_name LIKE 'A%';

-- a ile biten
SELECT *
FROM actor
WHERE first_name LIKE '%a';

-- İçinde en olan
SELECT *
FROM actor
WHERE first_name LIKE '%en%';

-- P ile başlayıp e ile biten
SELECT *
FROM actor
WHERE first_name LIKE 'P%e';

