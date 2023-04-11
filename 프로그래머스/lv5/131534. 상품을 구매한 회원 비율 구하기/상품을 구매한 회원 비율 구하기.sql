SELECT 
    #상품이 판매된 해
    YEAR(o.SALES_DATE) AS YEAR,
    #상품이 판매된 달
    MONTH(o.SALES_DATE) AS MONTH, 
    # ONLINE_SALE o 테이블에서 가져온 COUNT(DISTINCT USER_ID) 는 상품을 구매한 적이 있는 회원들의 수 (중복제거됨)
    COUNT(DISTINCT o.USER_ID) AS PURCHASED_USERS,
    ROUND(
        # (중복제거된 상품을 구매한 유저의 숫자 / 중복제거된 2021년에 가입한 회원들의 숫자 )
        (COUNT(DISTINCT(o.USER_ID)) / (SELECT COUNT(DISTINCT USER_ID) FROM USER_INFO WHERE YEAR(JOINED)=2021))
        # 소수점 첫번째자리까지 반올림
        ,1
    ) AS PURCHASED_RATIO
FROM ONLINE_SALE o
    INNER JOIN USER_INFO u ON u.USER_ID = o.USER_ID
WHERE YEAR(u.JOINED) = 2021
GROUP BY YEAR, MONTH
ORDER BY YEAR ASC, MONTH ASC;