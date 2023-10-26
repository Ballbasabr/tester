/*Составьте запрос, который выведет имя вида с наименьшим id. 
Результат будет соответствовать букве «М».*/
SELECT 
 *
FROM 
 species
WHERE species_id = (SELECT MIN(species_id)
                    FROM species);

/*Составьте запрос, который выведет имя вида
с количеством представителей более 1800.
Результат будет соответствовать букве «Б».*/

SELECT 
 *
FROM 
 species
WHERE 
 species_amount > 1800;

/*Составьте запрос, который выведет имя вида,
начинающегося на «п» и относящегося к типу с type_id = 5. 
Результат будет соответствовать букве «О».*/

SELECT 
 *
FROM 
 species
WHERE 
 species_name LIKE 'п%' AND type_id = 5; 

/*Составьте запрос, который выведет имя вида, заканчивающегося
на «са» или количество представителей которого равно 5. 
Результат будет соответствовать букве В.*/

SELECT 
 *
FROM 
 species
WHERE  
 species_name LIKE '%са%' or species_amount = 5;

/*Составьте запрос, который выведет имя вида, 
появившегося на учете в 2023 году. 
Результат будет соответствовать букве «Ы».*/

SELECT 
 *
FROM 
 species
WHERE  
 date_start BETWEEN '2023-01-01' AND '2024-01-01';

/*Составьте запрос, который выведет названия отсутствующего 
(status = absent) вида, расположенного вместе с place_id = 3. 
Результат будет соответствовать букве «С».*/

SELECT 
 p.place_id, p.place_name, s.species_name, s.species_status
FROM 
 places as p JOIN species_in_places as sip
ON 
 p.place_id = sip.place_id
JOIN 
 species as s
ON
 sip.species_id = s.species_id
WHERE 
 s.species_status = 'absent' and p.place_id = 3;

/*Составьте запрос, который выведет название вида, 
расположенного в доме и появившегося в мае, 
а также и количество представителей вида. 
Название вида будет соответствовать букве «П».*/

SELECT  
 p.place_name, s.species_name, s.date_start, s.species_amount
FROM 
 places as p join species_in_places as sip
ON 
 p.place_id = sip.place_id
JOIN 
 species as s
ON
 sip.species_id = s.species_id
WHERE 
 EXTRACT(MONTH FROM date_start) = '05' and p.place_name = 'дом';

/*Составьте запрос, который выведет название вида, 
состоящего из двух слов (содержит пробел). 
Результат будет соответствовать знаку !.*/

SELECT 
 *
FROM 
 species 
WHERE 
 date_start IN (SELECT date_start
				FROM species  
				WHERE species_name = 'малыш'); 

/*Составьте запрос, который выведет имя вида, 
появившегося с малышом в один день. 
Результат будет соответствовать букве «Ч».*/

SELECT 
 p.place_size, p.place_name, s.species_name
FROM 
 places as p JOIN species_in_places as sip
ON
 p.place_id = sip.place_id
JOIN 
 species as s
ON
 sip.species_id = s.species_id
WHERE  
 p.place_size = (SELECT MAX(place_size)
                 FROM places
                 WHERE (place_name = 'дом' OR place_name = 'сарай'))

/*Составьте запрос, который выведет название вида, 
расположенного в здании с наибольшей площадью. 
Результат будет соответствовать букве «Ж».*/

SELECT  
 p.place_name, s.species_name, s.date_start, s.species_amount, s.type_id
FROM 
 places as p JOIN species_in_places as sip
ON
 p.place_id = sip.place_id
JOIN 
 species as s
ON
 sip.species_id = s.species_id
WHERE 
 p.place_name = 'дом'

/*Составьте запрос/запросы, которые найдут название вида, 
относящегося к 5-й по численности группе проживающего дома. 
Результат будет соответствовать букве «Ш».*/

SELECT  
 p.place_name, s.species_name, s.species_amount, s.type_id
FROM 
 places as p JOIN species_in_places as sip
ON 
 p.place_id = sip.place_id
JOIN 
 species as s
ON 
 sip.species_id = s.species_id
WHERE   
 p.place_name = 'дом'
ORDER BY 
 species_amount DESC
LIMIT 1 OFFSET 4;

/*Составьте запрос, который выведет сказочный вид (статус fairy), 
не расположенный ни в одном месте. 
Результат будет соответствовать букве «Т».*/

SELECT  
 p.*, s.*
FROM 
 places as p FULL JOIN species_in_places as sip
ON 
 p.place_id = sip.place_id
FULL JOIN 
 species as s
ON 
 sip.species_id = s.species_id
WHERE 
 s.species_status = 'fairy' and p.place_name IS NULL;
 
