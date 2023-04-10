SELECT 
ANIMAL_ID,
NAME,
# IF(SEX_UPON_INTAKE REGEXP 'Neutered|Spayed', 'O', 'X') 중성화
(
    CASE
    WHEN SEX_UPON_INTAKE 
        LIKE '%Neutered%' 
    OR SEX_UPON_INTAKE 
        LIKE '%Spayed%' 
    THEN 'O' ELSE 'X'  
    END
) AS 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID