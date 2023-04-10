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

# 여기서 문제는 GROUP BY CAR_ID에 있는데 같은 CAR_ID라도 여러번 대여가 가능한데 AVAILABILITY는 그걸 반영하지 못함
# 서브쿼리를 활용해서 CASE문을 좀 수정해야한다.
