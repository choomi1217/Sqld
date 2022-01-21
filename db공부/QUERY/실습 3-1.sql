ALTER SESSION SET optimizer_mode = 'ALL_ROWS' ;

ALTER SESSION SET optimizer_mode = FIRST_ROWS_1000;

ALTER SESSION SET optimizer_mode = 'FIRST_ROWS' ;

SELECT * 
  FROM edu.t 
WHERE owner = 'SYS'
ORDER BY created;


SELECT /*+ FIRST_ROWS */ * 
  FROM edu.t
WHERE owner = 'SYS'
ORDER BY created;

SELECT *
  FROM edu.실시간환율;
  
 /*2019-06-01*/
-- INDEX 가 심볼, 거래일시, 해외은행코드 순으로 들어있음
-- 현재 FULL 탐

SELECT  종목영문심볼, 거래일시, SUBSTR(거래일시,9,6) 거래시각, 현재환율가격
  FROM  edu.실시간환율
 WHERE  종목영문심볼 = 'USDKRWCOMP' 
   AND  SUBSTR(거래일시,1,8) = '20190601' 
   AND  해외은행코드 = 'EUAM'
  AND  SUBSTR(거래일시,9,6) >= '090000'
   AND  SUBSTR(거래일시,9,6) <= '150000'
;

SELECT 종목영문심볼, 거래일시, SUBSTR(거래일시,9,6) 거래시각, 현재환율가격
  FROM  edu.실시간환율
  WHERE  SUBSTR(거래일시,9,6) <= '150000';

20190609223935
20190601090000

SELECT 종목영문심볼, 거래일시, SUBSTR(거래일시,9,6) 거래시각, 현재환율가격
  FROM  edu.실시간환율
WHERE  종목영문심볼 = 'USDKRWCOMP'   AND  해외은행코드 = 'EUAM'  AND 거래일시 BETWEEN '20190601090000' AND '20190601150000';

SELECT 종목영문심볼, 거래일시, SUBSTR(거래일시,9,6) 거래시각, 현재환율가격
  FROM  edu.실시간환율
WHERE  종목영문심볼 = 'USDKRWCOMP'   AND  해외은행코드 = 'EUAM'  AND 거래일시 BETWEEN :trdDd || '090000' AND :trdDd || '150000';


select /*+ index(e) */ *
from   emp e
where (job = 'CLERK'
       or
       ename = 'SMITH');







