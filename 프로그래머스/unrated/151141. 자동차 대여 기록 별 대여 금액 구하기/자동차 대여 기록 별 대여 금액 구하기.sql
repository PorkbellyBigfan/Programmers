# 출력해야 하는것
# HISTORY_ID (대여기록ID), 대여기록별 대여금액 (DAILY_FEE * 대여기간 * DISCOUNT)AS FEE

# 고려해야 하는것
# CAR_TYPE이 '트럭'
# 대여기간에 따른 할인비율이 다름. 이것에 관련된 쿼리문을 작성해야함. SELECT 절에 CASE구문을 사용?

# 정렬조건
# 대여금액 기준 내림차순, 대여금액이 같을 경우 대여기록ID 기준으로 내림차순(ORDER BY FEE DESC, HISTORY_ID DESC;)


SELECT 
    HISTORY_ID, 
    # CAR_TYPE, 
    # DAILY_FEE, 
    # DATEDIFF(END_DATE, START_DATE)+1 AS RENTAL_PERIOD,
    # (DAILY_FEE * (DATEDIFF(END_DATE, START_DATE)+1)) AS TOTAL_FEE_BEFORE_DISCOUNT,
    CASE
        # 7일미만의 DURATION_TYPE 인 경우 할인 없음
        WHEN DATEDIFF(END_DATE, START_DATE)+1< 7 
        THEN CEIL(DAILY_FEE * (DATEDIFF(END_DATE, START_DATE)+1))
        
        # 7일 이상의 DURATION_TYPE, CAR_TYPE = '트럭'
        WHEN DATEDIFF(END_DATE, START_DATE)+1< 30
        THEN 
        CEIL(
            DAILY_FEE * 
            (DATEDIFF(END_DATE, START_DATE)+1) * 
            (
                SELECT (100-DISCOUNT_RATE)/100
                FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                WHERE CAR_TYPE = '트럭' AND DURATION_TYPE ='7일 이상'
            )
        )
    
        # 30일 이상, 90일 미만의 DURATION_TYPE, AND CAR_TYPE = '트럭'
        WHEN DATEDIFF(END_DATE, START_DATE)+1 BETWEEN 30 AND 89
        THEN 
        CEIL(
            DAILY_FEE * 
            (DATEDIFF(END_DATE, START_DATE)+1) * 
            (
                SELECT (100-DISCOUNT_RATE)/100
                FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                WHERE CAR_TYPE = '트럭' AND DURATION_TYPE ='30일 이상'
            )
        )
        # 90일 이상의 DURATION TYPE, AND CAR_TYPE = '트럭'
        WHEN DATEDIFF(END_DATE, START_DATE)+1 >= 90
        THEN 
        CEIL(
            DAILY_FEE * 
            (DATEDIFF(END_DATE, START_DATE)+1) * 
            (
                SELECT (100-DISCOUNT_RATE)/100
                FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                WHERE CAR_TYPE = '트럭' AND DURATION_TYPE ='90일 이상'
            )
        )
    END AS FEE
FROM CAR_RENTAL_COMPANY_CAR c
INNER JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY h ON h.CAR_ID = c.CAR_ID
WHERE CAR_TYPE = '트럭'
GROUP BY HISTORY_ID
ORDER BY FEE DESC, HISTORY_ID DESC;