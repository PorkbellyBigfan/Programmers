SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS o
WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS)