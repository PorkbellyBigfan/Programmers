SELECT 
    CAR_ID,
    # DATE_FORMAT(END_DATE, '%Y-%m-%d'),
    CASE 
        WHEN CAR_ID IN (
            SELECT CAR_ID 
            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
            WHERE DATE('2022-10-16') BETWEEN START_DATE AND END_DATE
        ) THEN '대여중'
        ELSE '대여 가능'
    END AS AVAILABILITY 
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;

# 나의 문제 풀이 과정과 해설 https://porkbellyyam.tistory.com/55
