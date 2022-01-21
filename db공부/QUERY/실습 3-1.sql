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
  FROM edu.�ǽð�ȯ��;
  
 /*2019-06-01*/
-- INDEX �� �ɺ�, �ŷ��Ͻ�, �ؿ������ڵ� ������ �������
-- ���� FULL Ž

SELECT  ���񿵹��ɺ�, �ŷ��Ͻ�, SUBSTR(�ŷ��Ͻ�,9,6) �ŷ��ð�, ����ȯ������
  FROM  edu.�ǽð�ȯ��
 WHERE  ���񿵹��ɺ� = 'USDKRWCOMP' 
   AND  SUBSTR(�ŷ��Ͻ�,1,8) = '20190601' 
   AND  �ؿ������ڵ� = 'EUAM'
  AND  SUBSTR(�ŷ��Ͻ�,9,6) >= '090000'
   AND  SUBSTR(�ŷ��Ͻ�,9,6) <= '150000'
;

SELECT ���񿵹��ɺ�, �ŷ��Ͻ�, SUBSTR(�ŷ��Ͻ�,9,6) �ŷ��ð�, ����ȯ������
  FROM  edu.�ǽð�ȯ��
  WHERE  SUBSTR(�ŷ��Ͻ�,9,6) <= '150000';

20190609223935
20190601090000

SELECT ���񿵹��ɺ�, �ŷ��Ͻ�, SUBSTR(�ŷ��Ͻ�,9,6) �ŷ��ð�, ����ȯ������
  FROM  edu.�ǽð�ȯ��
WHERE  ���񿵹��ɺ� = 'USDKRWCOMP'   AND  �ؿ������ڵ� = 'EUAM'  AND �ŷ��Ͻ� BETWEEN '20190601090000' AND '20190601150000';

SELECT ���񿵹��ɺ�, �ŷ��Ͻ�, SUBSTR(�ŷ��Ͻ�,9,6) �ŷ��ð�, ����ȯ������
  FROM  edu.�ǽð�ȯ��
WHERE  ���񿵹��ɺ� = 'USDKRWCOMP'   AND  �ؿ������ڵ� = 'EUAM'  AND �ŷ��Ͻ� BETWEEN :trdDd || '090000' AND :trdDd || '150000';


select /*+ index(e) */ *
from   emp e
where (job = 'CLERK'
       or
       ename = 'SMITH');







