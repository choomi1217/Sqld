SELECT
SUM(IF(A=1,1,0)),
SUM(IF(A=2,1,0)),
SUM(IF(A=3,1,0)),
SUM(IF(A=4,1,0))
FROM T1;

SELECT * FROM T1;

SELECT A, COUNT(*), SUM(A)
FROM T1
GROUP BY A
ORDER BY A;

SELECT SUM(DECODE(A, 1, 1, 0)) AS A1, COUNT(*) FROM t1 GROUP BY A
UNION
SELECT SUM(DECODE(A, 2, 2, 0)) AS A2, COUNT(*) FROM t1 GROUP BY A
UNION
SELECT SUM(DECODE(A, 3, 3, 0)) AS A3, COUNT(*) FROM t1 GROUP BY A
UNION
SELECT SUM(DECODE(A, 4, 4, 0)) AS A4, COUNT(*) FROM t1 GROUP BY A
;

-- A || B 
SELECT CONCAT(A,B)AS AB, C FROM T1;
SELECT A || B AS AB, C FROM T1;

SELECT LENGTH(SUBSTR(A,2,4))+ LENGTH(LTRIM(B, '0')) AS R1 FROM T1;

SELECT SUBSTR(A,2,4)AS SUB_A FROM T1;

--FLOOR(내림) , CEIL(올림) , TRUNC(버림) , ROUND(반올림)
SELECT FLOOR(14.5) AS R FROM DUAL 
UNION
SELECT CEIL(14.5) AS R FROM DUAL
UNION ALL
SELECT TRUNC(15.4,0) AS R FROM DUAL
UNION ALL
SELECT ROUND(15.4) AS R FROM DUAL;

-- CREATE PUBLIC DATABASE LINK cho_link CONNECT TO scott IDENTIFIED BY "1217" USING 'TNS';
-- 오늘 집에 가서 'TNS'알아오기
-- CREATE  PUBLIC DATABASE LINK TESTUSER_LINK 
-- CONNECT TO R_USER IDENTIFIED BY "RPassword" USING 'TestUser_TNS';
-- TestUser_TNS 는 원격지 오라클 서버에 접속하기위해서 
-- 로컬 오라클 서버의 tnsnames.ora 파일에 설정되어 있는 연결정보 이름

SELECT CASE WHEN A = 3 THEN 'A'
            WHEN SUBSTR(B,2,1) = 'B' THEN 'B'
            ELSE 'C'
            END AS R1
        FROM T1;
        
SELECT * FROM T1 WHERE (A=1 AND B='A') OR (A=3 AND B='C');
SELECT * FROM T1 WHERE (A,B) IN ((1,'A'),(3,'C'));

SELECT SUM(DECODE(B,'A',A,'B',1))AS R1 FROM T1;

SELECT A, MIN(B) + NVL(MAX(C),0)AS R1
FROM T1
GROUP BY A
ORDER BY A;

CREATE TABLE 주문(
주문번호 VARCHAR2(20)
);

SELECT MIN(주문합계금액) AS 최저주문금액
FROM (
        SELECT A.고객번호, A.주문일자, SUM(B.주문금액) AS 주문합계금액
        FROM 주문 A, 주문 B
        WHERE B.고객번호 = A.고객번호
        AND B.주문일자 <= A.주문일자
        GROUP BY A.고객번호, A.주문일자
        ORDER BY 고객번호, 주문일자
    );
    
    
SELECT 고객번호, MAX(주문합계금액) AS 총합주문금액
FROM (
        SELECT A.고객번호, A.주문일자, SUM(B.주문금액) AS 주문합계금액
        FROM 주문 A, 주문 B
        WHERE B.고객번호 = A.고객번호
        AND B.주문일자 <= A.주문일자
        GROUP BY A.고객번호, A.주문일자
        ORDER BY 고객번호, 주문일자
    )
GROUP BY 고객번호;


SELECT A.고객번호, A.주문일자, SUM(B.주문금액) AS 주문합계금액
FROM 주문 A, 주문 B
WHERE B.고객번호 = A.고객번호
AND B.주문일자 <= A.주문일자
GROUP BY A.고객번호, A.주문일자
ORDER BY 고객번호, 주문일자;
        
SELECT  A.주문일자, SUM(B.주문금액) AS 주문합계금액
FROM 주문 A, 주문 B
WHERE B.주문일자 <= A.주문일자
GROUP BY  A.주문일자
ORDER BY 주문일자;

--(+)기호가 붙은 주문 테이블이 이너
-- 기호가 안 붙은 고객 테이블이 아우터가 되어 주문 테이블은 조건에 맞는것만
SELECT SUM(B.주문금액) / COUNT (DISTINCT A.고객번호) AS R1
FROM 고객 A, 주문 B
WHERE B.고객번호(+) = A.고객번호
AND B.주문금액(+) > 10000;

SELECT COUNT(*) AS R1
FROM T1 A, T2 B
WHERE A.A >=2
AND B.B IN ('A','C');

SELECT A.A, A.B, B.A , B.B
FROM T1 A, T2 B
WHERE A.A >=2
AND B.B IN ('A','C');

SELECT A.A, A.B, B.A , B.B
FROM T1 A, T2 B
WHERE A.A = B.A
AND A.A >=2;
--AND B.B IN ('A','C');

SELECT SUM(B.B) AS R1
FROM T1 A INNER JOIN T2 B
ON B.A = A.A
WHERE A.A >= 2;

SELECT SUM(A) AS R1
FROM T1 A NATURAL JOIN T2 B;

-- 오류 O
-- JOIN을 위해 USING절에 사용한 컬럼은 
-- 테이블명.컬럼이 아니라 그냥 컬럼으로 와야함
SELECT A.A , B.CC
FROM T1 A JOIN T2 B
USING(A);
-- 오류 X
SELECT A , B.CC
FROM T1 A JOIN T2 B
USING(A);

SELECT 
COUNT(A.A) AS CNT_A,
COUNT(B.A) AS CNT_B 
FROM T1 A RIGHT OUTER JOIN T2 B
ON B.A = A.A
WHERE B.A >= 3;
-- 2, 3

CREATE TABLE EMP
(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2)
);

COMMIT;

SELECT *
 FROM EMP
WHERE SAL > (SELECT SAL 
              FROM ( SELECT SAL FROM EMP ORDER BY HIREDATE DESC)
              WHERE ROWNUM =1 );
              
SELECT *
 FROM EMP
WHERE SAL < (SELECT DISTINCT SAL
              FROM ( SELECT SAL, RANK() OVER(ORDER BY SAL DESC) AS RK
                     FROM EMP
                     WHERE SAL < 1300 )
             WHERE RK = 1);

SELECT COUNT(*)
  FROM T1 A
 WHERE EXISTS (SELECT 1 FROM T2 B WHERE B.C1 = C1);
 
 
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE (deptno,sal) in (
                        SELECT deptno,max(sal)
                        FROM emp
                        GROUP BY deptno);

SELECT
    empno,
    ename,
    sal,
    deptno
FROM (
        SELECT A.* ,
        RANK()OVER(PARTITION BY deptno ORDER BY sal DESC) AS RK
        FROM emp A
        ORDER BY deptno, RK)
WHERE RK = 1;

--카티시안 곱이 되어 나오는 결과
SELECT *
FROM t1 A CROSS JOIN t2 B;

-- 공통된 결과만 조회 하되 가장 많은 행을 가진 테이블의 카디널리티만큼 나옴 
SELECT *
FROM t1 A INNER JOIN t2 B
ON B.C1 = A.C1;

-- 중복된 내용 제거하고 조인
SELECT *
FROM t1 A NATURAL JOIN t2 B;

-- 왼쪽의 테이블의 데이터는 모두 출력
SELECT * FROM t1 A LEFT OUTER JOIN t2 B
USING(C1);

SELECT SUBSTR('ABCDEFG',1,2)
FROM DUAL;

SELECT SUBSTRB('ABCDEFG',5,4.2)
FROM DUAL;

SELECT SUBSTR('ABCDEFG',5)
FROM DUAL;

SELECT NVL(C1,0) +  NULLIF( C2,100) AS R1
FROM T1;

SELECT NULLIF( C2,100) AS R1
FROM T1;

SELECT AVG(C1+C2) AS R1 FROM T1;

SELECT TO_NUMBER( SUBSTR (sal_ename, 1, 4)) AS SAL    
FROM(SELECT( SELECT MAX(LPAD(sal,4,'0') || ename)
             FROM emp x
             WHERE x.deptno = a.deptno ) AS sal_ename
      FROM dept a
      WHERE a.deptno = 20);
      
SELECT MAX(LPAD(sal,4,'0') || ename)
  FROM emp x, dept a
 WHERE x.deptno = a.deptno
   AND a.deptno = 20;



SELECT * FROM DEPT WHERE DEPTNO=20;

--LAPD, RPAD : 문자열의 길이를 맞춰야 할 때 길이만큼 공백문자를 채움
--LPAX(대상, 문자열 길이, 채울 문자)
SELECT LPAD(sal,4,'0')
FROM emp
ORDER BY empno;

-- select 문에서 다시 select를 하는 스칼라 서브 쿼리는 단일행만을 반환해야함
SELECT ( SELECT T1.C1 FROM T1 WHERE T1.C1 = T2.C1 ) AS T1_C1
 FROM T2
 WHERE T2.C1 = 2;
 
SELECT(SELECT MAX(LPAD(sal,4,'0') || ename) FROM emp x WHERE x.deptno = a.deptno) AS sal_ename
FROM dept a
WHERE a.deptno = 20;

--스칼라 서브쿼리로 2번 조회
SELECT A.DEPTNO, A.DNAME 
        ,(
            SELECT MAX(X.SAL) 
            FROM EMP X
            WHERE X.DEPTNO = A.DEPTNO
         )AS SAL
        ,(
             SELECT MAX(X.COMM) 
             FROM EMP X
             WHERE X.DEPTNO = A.DEPTNO
         )AS COMM
FROM DEPT A;

--인라인뷰로 1번 조회
-- SAL과 COMM이 가장 많은 사원의 DEPT를 찾는 쿼린가?
SELECT A.DEPTNO, A.DNAME, B.SAL, B.COMM
  FROM DEPT A
        ,(
            SELECT DEPTNO, MAX(SAL) AS SAL, MAX(COMM) AS COMM
            FROM EMP
            GROUP BY DEPTNO
         )B
 WHERE A.DEPTNO = B.DEPTNO(+);
 
SELECT COUNT(*)AS CNT
 FROM ( 
        SELECT C1 FROM T1 
        UNION
        SELECT C1 FROM T2
        MINUS
        SELECT C1 FROM T3 
        );

SELECT C1 , SUM(C2) AS C2, SUM(C3) AS C3
 FROM (SELECT C1,C2,NULL AS C3 FROM T1
       UNION ALL
       SELECT C1, NULL AS C2, C3 FROM T2)
GROUP BY C1
ORDER BY C1;

SELECT C1 FROM T1
MINUS
SELECT C1 FROM T2;

SELECT DISTINCT A.C1
FROM T1 A
WHERE NOT EXISTS ( SELECT 1 FROM T2 X WHERE X.C1 = A.C1);

SELECT 1
FROM T2 X, T1 A
WHERE X.C1 = A.C1;

SELECT C1 FROM T1
INTERSECT
SELECT C1 FROM T2;

SELECT DISTINCT A.C1
 FROM T1 A
 WHERE EXISTS ( SELECT 1 FROM T2 X WHERE X.C1 = A.C1);

--ROLLUP같은 통계 함수는 순서도 중요
--앞에 나온 C2를 중심으로 묶고 다음 조건을 중심으로 또 묶음
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C2,C1);

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C1,C2);

SELECT C1, C2, SUM(C3) AS C3
 FROM T1
GROUP BY CUBE(C1,C2); 


-- CUBE와 ROLLUP 없이 할 수 있는 통계
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY GROUPING SETS ((C1,C2),C1);

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY GROUPING SETS (C1,C2);

-- JOB 소계와 DEPTNO 소계를 합친 쿼리
SELECT job, deptno, COUNT(*) cnt
  FROM EMP
 GROUP BY GROUPING SETS(job, deptno)
 ORDER BY job, deptno;

SELECT deptno,job, COUNT(*) cnt
 FROM EMP
GROUP BY job,deptno
UNION ALL 
SELECT deptno,job, COUNT(*) cnt
 FROM EMP 
GROUP BY deptno,job;


SELECT C1, C2
FROM T1 NATURAL JOIN T2;

--그냥 조인을 하면 RIGHT OUTER JOIN과 다를게 없음
SELECT *
FROM  T1 JOIN T2
USING(C1);

SELECT *
FROM  T1 RIGHT OUTER JOIN T2
USING(C1);

SELECT *
FROM  T1 LEFT OUTER JOIN T2
USING(C1);

-- GROUPING SETS 일반적인 사용
SELECT JOB, DEPTNO , COUNT(*)
FROM EMP 
GROUP BY GROUPING SETS((JOB,DEPTNO))
ORDER BY JOB, DEPTNO;
-- 괄호 안에 아무것도 안 넣으면 총합이 뽑아짐 ㅇ0ㅇ
SELECT JOB, DEPTNO , COUNT(*)
FROM EMP 
GROUP BY GROUPING SETS((JOB,DEPTNO),())
ORDER BY JOB, DEPTNO;

SELECT JOB, MGR, DEPTNO, COUNT(*)CNT
FROM EMP
GROUP BY GROUPING SETS((JOB,MGR),(JOB,DEPTNO))
ORDER BY JOB, DEPTNO;

SELECT JOB, MGR, DEPTNO, COUNT(*)CNT
FROM EMP
GROUP BY GROUPING SETS((JOB,MGR),(JOB,DEPTNO),())
ORDER BY JOB, DEPTNO;

SELECT DECODE(GROUPING(JOB),1,'합계',JOB) JOB, 
       DEPTNO, 
       COUNT(*) CNT
 FROM EMP
GROUP BY GROUPING SETS((JOB,DEPTNO),());

--DECODE에 대해 좀 더 자세히 알아보자
SELECT ename AS 직원성명, 
       deptno AS 부서번호,
       decode(deptno, 10, '10', 'X') as DECODE  
FROM emp;
--DECODE안에 DECODE가 들어감
--DEPTNO가 20이면 DECODE안으로 다시 들어가거나 하는 형태
select ename,
       deptno,
       decode(deptno, 20, decode(ename, 'SMITH', '금주당직', '다음주 당직'), null) as 비고
from emp
order by deptno;

-- 그룹함수에서 괄호열을 조합열이라고 함 (C1,C2), 하나의 단위로 본다 
-- ROLLUP은 보통 2개의 단위로 묶으면 3레벨이 되어 나오는데 괄호열로 묶으면 하나로 취급
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP((C1,C2));

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C1,C2);

-- RANK함수는 이어진 OVER절에 ORDER BY한 걸 순위를 매겨서 돌려줌
-- 중복순위가 4, 4 이렇게 되면 다음 순위는 6으로 친다.
SELECT EMPNO, ENAME, SAL, RANK () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

-- DENSE_RANK는 중북 순위 다음 숫자를 이어서 4, 4 라면 다음 순위는 5다.
SELECT EMPNO, ENAME, SAL, DENSE_RANK () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

-- ROW_NUMBER도 순서매겨지긴 함
SELECT EMPNO, ENAME, SAL, ROW_NUMBER () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER (ORDER BY SAL) AS C1
FROM EMP
WHERE DEPTNO = 20;

--윈도우 함수를 적용할 때, 조회된 모든 데이터가 아닌 특정 행의 범위를 지정
SELECT EMPNO, ENAME, SAL
       , SUM(SAL) OVER (ORDER BY SAL) AS C1
       , SUM(SAL) OVER (ORDER BY SAL RANGE UNBOUNDED PRECEDING) AS C2
 FROM EMP
WHERE DEPTNO = 20;

-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT dept, id, salary,
       SUM(salary) OVER 
       (PARTITION BY dept ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) col
  FROM (
          SELECT 20 dept, 100 id, 20000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 101 id, 30000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 101 id, 10000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 102 id,  9000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 103 id, 17000 salary FROM DUAL
       ) D;

-- RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- RANGE는 ORDER BY 컬럼으로 사용된 id 값이 같은 컬럼을 묶어서 연산
SELECT dept, id, salary,
       SUM(salary) OVER 
       (PARTITION BY dept ORDER BY id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) col2
  FROM (
          SELECT 20 dept, 100 id, 20000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 101 id, 30000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 101 id, 10000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 102 id,  9000 salary FROM DUAL UNION ALL
          SELECT 20 dept, 103 id, 17000 salary FROM DUAL 
       ) D;

-- UNBOUNDED PRECEDING : 윈도우 시작 위치가 첫 번째 로우임을 의미
-- UNBOUNDED FOLLOWING : 윈도우 마지막 위치가 마지막 로우임을 의미
-- BETWEEN ~ AND : 윈도우의 시작과 끝 위치를 지정
-- [ROW수] PRECEDING : 윈도우 시작 위치가 ROW수만큼 이전이 시작 로우임을 의미
-- [ROW수] FOLLOWING : 윈도우 마지막 위치가 ROW수만큼 다음이 마지막 로우임을 의미
-- CURRENT ROW : 현재 로우까지를 의미
-- SAL RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING
-- : SAL값에서 50을 빼고 100을 더한 값이 윈도우가 됨
-- 즉, FORD는 SAL이 3000이니까 SAL이 2950 ~ 3100 인 컬럼을 카운트함
-- , JONES, SCOTT, FORD가 카운트 되어 3
SELECT EMPNO, ENAME, SAL
,COUNT(*)OVER( ORDER BY SAL RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING) AS C1
FROM EMP 
WHERE DEPTNO = 20;

-- 이렇게 조회하면 SAL겹치는 애가 안 나옴
SELECT EMPNO, ENAME, SAL, ROWNUM AS RN
FROM EMP
WHERE DEPTNO IN (20,30)
AND ROWNUM <= 3
ORDER BY SAL DESC;

-- 겹치는 애까지 조회 하려면
SELECT A.*
      ,ROWNUM AS RN
 FROM (SELECT EMPNO, ENAME, SAL
        FROM EMP
        WHERE DEPTNO IN (20,30)
        ORDER BY SAL DESC) A
 WHERE ROWNUM <= 3;


-- Top-N Query
-- 상위 N개의 데이터를 보여주기 위해 Top-N Query

--TOP (4) MSSQL
SELECT TOP(4) WITH TIES * 
 FROM EMP
ORDER BY SAL DESC;

-- ORACLE
SELECT A.* , ROWNUM AS RN
FROM
    (
        SELECT *
        FROM EMP
        ORDER BY SAL DESC
    ) A
WHERE ROWNUM <= 4;

-- 페이징쿼리 
SELECT *
FROM(
        SELECT A.*, ROWNUM AS RN
        FROM(
             SELECT EMPNO, ENAME, SAL
             FROM EMP
             ORDER BY SAL DESC
            )A
        WHERE ROWNUM <= 10
    )
WHERE RN >= 6;

-- ROW LIMITING : 11G인 버전에선 안 되고 12C부터 가능

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC OFFSET 3 ROWS;

select * from v$version;

--계층형 쿼리
CREATE TABLE BOM (
     ITEM_ID INTEGER NOT NULL, -- 품목식별자
     PARENT_ID INTEGER, -- 상위품목 식별자
     ITEM_NAME VARCHAR2(20) NOT NULL, -- 품목이름
     ITEM_QTY INTEGER, -- 품목 개수
     PRIMARY KEY (ITEM_ID)
);

INSERT INTO BOM VALUES ( 1001, NULL, '컴퓨터', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '본체', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '모니터', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '프린터', 1);

INSERT INTO BOM VALUES ( 1005, 1002, '메인보드', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '랜카드', 1);
INSERT INTO BOM VALUES ( 1007, 1002, '파워서플라이', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '그래픽카드', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '기타장치', 1);

SELECT bom1.item_name,
        bom1.item_id,
        bom2.item_name parent_item
 FROM bom bom1, bom bom2
WHERE bom1.parent_id = bom2.item_id(+)
ORDER BY bom1.item_id;

SELECT item_name, item_id, parent_id
 FROM bom
START WITH parent_id IS NULL 
CONNECT BY PRIOR item_id = parent_id
ORDER BY PARENT_ID;

SELECT LPAD(' ', 2*(LEVEL-1)) || item_name item_names,
        item_id, 
        parent_id
 FROM bom
START WITH parent_id IS NULL 
CONNECT BY PRIOR item_id = parent_id
ORDER BY PARENT_ID;

SELECT  LPAD(' ', 2*(LEVEL-1)) || EMPNO AS EMPNO, ENAME, MGR
FROM EMP
START WITH ENAME = 'JONES'
CONNECT BY MGR = PRIOR EMPNO;

-- CTE (COMMON TABLE EXPRESSION) : WITH절을 이용해 임시테이블을 생성
WITH W1 (EMPNO, ENAME, MGR, LV) AS
     (
          SELECT EMPNO,ENAME,MGR, 1 AS LV
            FROM EMP
           WHERE ENAME = 'JONES'
          UNION ALL
          SELECT C.EMPNO, C.ENAME, C.MGR, P.LV+1
          FROM W1 P, EMP C
          WHERE C.MGR = P.EMPNO
     )
SELECT * FROM W1;

--PIVOT : 행을 열로 전환
-- SELECT *
--   FROM ( 피벗 대상 쿼리문 )
--  PIVOT ( 그룹합수(집계컬럼,행) FOR 피벗컬럼(열) IN (피벗컬럼값 AS 별칭 ... )

SELECT * 
 FROM ( SELECT JOB, DEPTNO, SAL FROM EMP WHERE DEPTNO IN (10,20) )
PIVOT ( SUM(SAL) FOR DEPTNO IN (10,20) )ORDER BY JOB;

-- Fmmm : 03, 04 이런 식으로 나오는 월을 3, 4 이렇게
SELECT * 
  FROM ( 
         SELECT job , TO_CHAR(hiredate, 'FMMM') || '월' hire_month 
           FROM emp 
       ) 
 PIVOT (
         COUNT(*) 
         FOR hire_month IN ('1월', '2월', '3월', '4월', '5월', '6월',
                            '7월', '8월', '9월', '10월', '11월', '12월') 
       );

SELECT * 
 FROM ( SELECT JOB, DEPTNO||'번 부서' AS DEPTNO, SAL FROM EMP WHERE DEPTNO IN (10,20) )
PIVOT ( SUM(SAL) FOR DEPTNO IN ('10번 부서','20번 부서') )ORDER BY JOB;

SELECT * 
 FROM ( SELECT JOB, DEPTNO, SAL FROM EMP WHERE DEPTNO IN (10,20) )
PIVOT ( SUM(SAL)AS SAL FOR DEPTNO IN (10,20) )ORDER BY JOB;

WITH  W1 (JOB, D10_SAL, D20_SAL, D30_SAL) AS
     (
          SELECT * 
            FROM (SELECT JOB, SAL, DEPTNO FROM EMP)
           PIVOT( SUM(SAL)AS SAL FOR DEPTNO IN (10,20,30)) ORDER BY JOB
     )
SELECT * FROM W1;

WITH  W1 (JOB, D10_SAL, D20_SAL, D30_SAL) AS
     (
          SELECT * 
            FROM (SELECT JOB, SAL, DEPTNO FROM EMP)
           PIVOT( SUM(SAL)AS SAL FOR DEPTNO IN (10,20,30)) ORDER BY JOB
     )
SELECT JOB, DEPTNO, SAL 
 FROM W1
 UNPIVOT (SAL FOR DEPTNO IN(D10_SAL, D20_SAL, D30_SAL))
WHERE JOB = 'CLERK'
ORDER BY JOB, DEPTNO;

WITH  W1 (JOB, D10_SAL, D20_SAL, D30_SAL) AS
     (
          SELECT * 
            FROM (SELECT JOB, SAL, DEPTNO FROM EMP)
           PIVOT( SUM(SAL)AS SAL FOR DEPTNO IN (10,20,30)) ORDER BY JOB
     )
SELECT JOB, DEPTNO, SAL 
 FROM W1
 UNPIVOT (SAL FOR DEPTNO IN(D10_SAL, D20_SAL, D30_SAL))
ORDER BY JOB, DEPTNO;

-- ORACLE의 정규표현식 사용법
SELECT REGEXP_SUBSTR('ABC', 'A.+') AS C1
       , REGEXP_SUBSTR( 'ABC', 'A.+?') AS C2
 FROM DUAL;

SELECT REGEXP_SUBSTR('ABD', 'AB||CD')AS C1,
       REGEXP_SUBSTR('ABD', 'A(B|C)D')AS C2
FROM DUAL;

SELECT REGEXP_SUBSTR('HTTP://WWW.ABC.COM/EFG', '([^:/]+)', 1, 1)AS C1
FROM DUAL;

SELECT REGEXP_SUBSTR('1A2B3C4D', '\D')AS C1 FROM DUAL;

SELECT EMPNO, ENMAE, SAL, COMM
       ,FIRST_VALUE(COMM IGNORE NULLS) OVER (ORDER BY SAL) AS C1
FROM EMP
WHERE DEPTNO = 30;

SELECT empno
     , ename
     , job
     , sal
     , LAG(empno) OVER(ORDER BY empno)  AS empno_prev
     , LEAD(empno) OVER(ORDER BY empno) AS empno_next
  FROM emp 
 WHERE job IN ('MANAGER', 'ANALYST', 'SALESMAN');

SELECT * 
  FROM ( SELECT A.EMPNO, A.ENAME, A.SAL, A.DEPTNO, B.DNAME
        FROM EMP A, DEPT B
        WHERE B.DEPTNO(+) = A.DEPTNO
        ORDER BY SAL DESC
      )
 WHERE ROWNUM <= 3;

--JOIN을 먼저 하는가 ROWNUM을 먼저 하는가
SELECT A.*, B.DNAME
  FROM 
      (
        SELECT EMPNO, ENAME,SAL, DEPTNO
          FROM EMP
        ORDER BY SAL DESC
      ) A
      ,DEPT B
 WHERE ROWNUM <=3
   AND B.DEPTNO(+) = A.DEPTNO;
 
SELECT *
  FROM EMP
 WHERE JOB <> 'ANALYST'
 START WITH ENAME = 'JONES'
CONNECT BY MGR = PRIOR EMPNO;

WITH W1 (EMPNO, ENAME, MGR) AS (
    SELECT EMPNO, ENAME, MGR
      FROM EMP
     WHERE ENAME = 'JONES'
    UNION ALL
    SELECT C.EMPNO, C.ENAME, C.MGR
      FROM W1 P, EMP C
     WHERE P.EMPNO = C.MGR )
SELECT EMPNO, ENAME, MGR
  FROM W1;

SELECT *
  FROM (
        SELECT JOB, TO_CHAR(HIREDATE, 'YYYY')AS YEAR, DEPTNO,SAL
          FROM EMP
         WHERE DEPTNO IN (10,30)
        )
 PIVOT (SUM(SAL) FOR DEPTNO IN(10,30))
ORDER BY JOB, YEAR;


WITH W1(JOB,D10_SAL, D20_SAL, D30_SAL) AS (
    SELECT *
    FROM (
            SELECT JOB, SAL, DEPTNO
              FROM EMP
         )
    PIVOT (SUM(SAL) FOR DEPTNO IN(10,20,30)) 
)
--SELECT * FROM W1;


SELECT *
FROM W1
UNPIVOT INCLUDE NULLS
    (
        SAL FOR DEPTNO IN(D10_SAL AS 10, D20_SAL AS 20, D30_SAL AS 30)
    )
WHERE JOB ='ANALYST';

SELECT REGEXP_SUBSTR('12AB34CD', '[A-Z]+$') AS C1 FROM DUAL;
SELECT REGEXP_SUBSTR('AABABCABCD', '(AB)C\1') AS C1 FROM DUAL;



select (seelct day from TABLEB where PT_NO = A.NO) as BDAY, A.NAME 
from TABLE A 
where BDAY;

SELECT A.ALIASS
FROM (SELECT ENAME, DEPTNO AS ALIASS FROM EMP WHERE DEPTNO ='10' )A, DEPT B;

-- 여기서부턴 DML

CREATE TABLE CT1 (
C1 NUMBER,
C2 NUMBER,
C3 NUMBER DEFAULT 3
);

INSERT INTO CT1 (C2) VALUES (1);

UPDATE T1 A 
   SET (A.C2, A.C3) = ( SELECT B.C2, B.C3
                          FROM T2 B
                         WHERE B.C1 = A.C1 );

DELETE FROM T1 WHERE C1 NOT IN ( SELECT C2 FROM T2 );

COMMIT;

CREATE TABLE TEAM_TEMP AS SELECT * FROM TEAM;

ALTER TABLE PLAYER ADD(ADRESS VARCHAR(80));

ALTER TABLE PLAYER DROP COLUMN ADRESS;

ALTER TABLE PLAYER DROP COLUMN ADRESS;

CREATE TABLE t
AS 
SELECT d.no, e.*
FROM emp e, (SELECT ROWNUM no FROM DUAL CONNECT BY LEVEL <= 1000) d;

CREATE INDEX t_idx01 ON t(deptno, no);
CREATE INDEX t_idx02 ON t(deptno, job, no);

-- https://cafe.naver.com/dbian/4385

SELECT NUM
      ,TYPE
      ,NAME
      ,DISPLAY_VALUE
      ,VALUE
--      ,DEFAULT_VALUE
      ,ISSES_MODIFIABLE
      ,ISSYS_MODIFIABLE
      ,ISINSTANCE_MODIFIABLE
      ,ISDEFAULT
      ,DESCRIPTION
  FROM V$PARAMETER
 WHERE UPPER(NAME) LIKE '%'|| UPPER('db_file')||'%'
ORDER BY TYPE DESC, NAME;

SELECT * FROM V$PARAMETER;

SELECT SUBSTR('1|2|3',INSTR('1|2|3','|')+1,INSTR('1|2|3','|')-1) as poi
FROM dual;

SELECT ID, substr(A.TXT,
              instr(A.TXT, '|', 1, LEVEL) + 1,
              instr(A.TXT, '|', 1, LEVEL + 1) - instr(A.TXT, '|', 1, LEVEL) - 1) TXT
   FROM (SELECT  'ASER' AS ID ,'|A|B|C|D|' TXT FROM dual) A
CONNECT BY LEVEL <= length(A.TXT) - length(REPLACE(A.TXT, '|')) - 1;

-- T 테이블에 통계정보를 수집
EXEC dbms_stats.gather_table_stats( user, 't');

SELECT * FROM T 
WHERE deptno = 10 AND NO = 1;

show parameter block_size;
-- v$가 뭔지 궁금해서 검색했더니 위 쿼리를 실행시켜 보라고 해서 실행시켰더니 여기에 TABLE_NAME이란 컬럼에 있다

select * from dict where TABLE_NAME LIKE 'V$%' ORDER BY TABLE_NAME;

select value from v$parameter where name = 'db_block_size';






















