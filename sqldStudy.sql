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

--FLOOR(����) , CEIL(�ø�) , TRUNC(����) , ROUND(�ݿø�)
SELECT FLOOR(14.5) AS R FROM DUAL 
UNION
SELECT CEIL(14.5) AS R FROM DUAL
UNION ALL
SELECT TRUNC(15.4,0) AS R FROM DUAL
UNION ALL
SELECT ROUND(15.4) AS R FROM DUAL;

-- CREATE PUBLIC DATABASE LINK cho_link CONNECT TO scott IDENTIFIED BY "1217" USING 'TNS';
-- ���� ���� ���� 'TNS'�˾ƿ���
-- CREATE  PUBLIC DATABASE LINK TESTUSER_LINK 
-- CONNECT TO R_USER IDENTIFIED BY "RPassword" USING 'TestUser_TNS';
-- TestUser_TNS �� ������ ����Ŭ ������ �����ϱ����ؼ� 
-- ���� ����Ŭ ������ tnsnames.ora ���Ͽ� �����Ǿ� �ִ� �������� �̸�

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

CREATE TABLE �ֹ�(
�ֹ���ȣ VARCHAR2(20)
);

SELECT MIN(�ֹ��հ�ݾ�) AS �����ֹ��ݾ�
FROM (
        SELECT A.����ȣ, A.�ֹ�����, SUM(B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
        FROM �ֹ� A, �ֹ� B
        WHERE B.����ȣ = A.����ȣ
        AND B.�ֹ����� <= A.�ֹ�����
        GROUP BY A.����ȣ, A.�ֹ�����
        ORDER BY ����ȣ, �ֹ�����
    );
    
    
SELECT ����ȣ, MAX(�ֹ��հ�ݾ�) AS �����ֹ��ݾ�
FROM (
        SELECT A.����ȣ, A.�ֹ�����, SUM(B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
        FROM �ֹ� A, �ֹ� B
        WHERE B.����ȣ = A.����ȣ
        AND B.�ֹ����� <= A.�ֹ�����
        GROUP BY A.����ȣ, A.�ֹ�����
        ORDER BY ����ȣ, �ֹ�����
    )
GROUP BY ����ȣ;


SELECT A.����ȣ, A.�ֹ�����, SUM(B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
FROM �ֹ� A, �ֹ� B
WHERE B.����ȣ = A.����ȣ
AND B.�ֹ����� <= A.�ֹ�����
GROUP BY A.����ȣ, A.�ֹ�����
ORDER BY ����ȣ, �ֹ�����;
        
SELECT  A.�ֹ�����, SUM(B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
FROM �ֹ� A, �ֹ� B
WHERE B.�ֹ����� <= A.�ֹ�����
GROUP BY  A.�ֹ�����
ORDER BY �ֹ�����;

--(+)��ȣ�� ���� �ֹ� ���̺��� �̳�
-- ��ȣ�� �� ���� �� ���̺��� �ƿ��Ͱ� �Ǿ� �ֹ� ���̺��� ���ǿ� �´°͸�
SELECT SUM(B.�ֹ��ݾ�) / COUNT (DISTINCT A.����ȣ) AS R1
FROM �� A, �ֹ� B
WHERE B.����ȣ(+) = A.����ȣ
AND B.�ֹ��ݾ�(+) > 10000;

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

-- ���� O
-- JOIN�� ���� USING���� ����� �÷��� 
-- ���̺��.�÷��� �ƴ϶� �׳� �÷����� �;���
SELECT A.A , B.CC
FROM T1 A JOIN T2 B
USING(A);
-- ���� X
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

--īƼ�þ� ���� �Ǿ� ������ ���
SELECT *
FROM t1 A CROSS JOIN t2 B;

-- ����� ����� ��ȸ �ϵ� ���� ���� ���� ���� ���̺��� ī��θ�Ƽ��ŭ ���� 
SELECT *
FROM t1 A INNER JOIN t2 B
ON B.C1 = A.C1;

-- �ߺ��� ���� �����ϰ� ����
SELECT *
FROM t1 A NATURAL JOIN t2 B;

-- ������ ���̺��� �����ʹ� ��� ���
SELECT * FROM t1 A LEFT OUTER JOIN t2 B
USING(C1);

SELECT SUBSTR('ABCDEFG',1,2)
FROM DUAL;

SELECT SUBSTRB('ABCDEFG',5,4.2)
FROM DUAL;'

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

--LAPD, RPAD : ���ڿ��� ���̸� ����� �� �� ���̸�ŭ ���鹮�ڸ� ä��
--LPAX(���, ���ڿ� ����, ä�� ����)
SELECT LPAD(sal,4,'0')
FROM emp
ORDER BY empno;

-- select ������ �ٽ� select�� �ϴ� ��Į�� ���� ������ �����ุ�� ��ȯ�ؾ���
SELECT ( SELECT T1.C1 FROM T1 WHERE T1.C1 = T2.C1 ) AS T1_C1
 FROM T2
 WHERE T2.C1 = 2;
 
SELECT(SELECT MAX(LPAD(sal,4,'0') || ename) FROM emp x WHERE x.deptno = a.deptno) AS sal_ename
FROM dept a
WHERE a.deptno = 20;

--��Į�� ���������� 2�� ��ȸ
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

--�ζ��κ�� 1�� ��ȸ
-- SAL�� COMM�� ���� ���� ����� DEPT�� ã�� ������?
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

--ROLLUP���� ��� �Լ��� ������ �߿�
--�տ� ���� C2�� �߽����� ���� ���� ������ �߽����� �� ����
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C2,C1);

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C1,C2);

SELECT C1, C2, SUM(C3) AS C3
 FROM T1
GROUP BY CUBE(C1,C2); 


-- CUBE�� ROLLUP ���� �� �� �ִ� ���
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY GROUPING SETS ((C1,C2),C1);

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY GROUPING SETS (C1,C2);

-- JOB �Ұ�� DEPTNO �Ұ踦 ��ģ ����
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

--�׳� ������ �ϸ� RIGHT OUTER JOIN�� �ٸ��� ����
SELECT *
FROM  T1 JOIN T2
USING(C1);

SELECT *
FROM  T1 RIGHT OUTER JOIN T2
USING(C1);

SELECT *
FROM  T1 LEFT OUTER JOIN T2
USING(C1);

-- GROUPING SETS �Ϲ����� ���
SELECT JOB, DEPTNO , COUNT(*)
FROM EMP 
GROUP BY GROUPING SETS((JOB,DEPTNO))
ORDER BY JOB, DEPTNO;
-- ��ȣ �ȿ� �ƹ��͵� �� ������ ������ �̾��� ��0��
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

SELECT DECODE(GROUPING(JOB),1,'�հ�',JOB) JOB, 
       DEPTNO, 
       COUNT(*) CNT
 FROM EMP
GROUP BY GROUPING SETS((JOB,DEPTNO),());

--DECODE�� ���� �� �� �ڼ��� �˾ƺ���
SELECT ename AS ��������, 
       deptno AS �μ���ȣ,
       decode(deptno, 10, '10', 'X') as DECODE  
FROM emp;
--DECODE�ȿ� DECODE�� ��
--DEPTNO�� 20�̸� DECODE������ �ٽ� ���ų� �ϴ� ����
select ename,
       deptno,
       decode(deptno, 20, decode(ename, 'SMITH', '���ִ���', '������ ����'), null) as ���
from emp
order by deptno;

-- �׷��Լ����� ��ȣ���� ���տ��̶�� �� (C1,C2), �ϳ��� ������ ���� 
-- ROLLUP�� ���� 2���� ������ ������ 3������ �Ǿ� �����µ� ��ȣ���� ������ �ϳ��� ���
SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP((C1,C2));

SELECT C1, C2, SUM(C3) AS C3
FROM T1
GROUP BY ROLLUP(C1,C2);

-- RANK�Լ��� �̾��� OVER���� ORDER BY�� �� ������ �Űܼ� ������
-- �ߺ������� 4, 4 �̷��� �Ǹ� ���� ������ 6���� ģ��.
SELECT EMPNO, ENAME, SAL, RANK () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

-- DENSE_RANK�� �ߺ� ���� ���� ���ڸ� �̾ 4, 4 ��� ���� ������ 5��.
SELECT EMPNO, ENAME, SAL, DENSE_RANK () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

-- ROW_NUMBER�� �����Ű����� ��
SELECT EMPNO, ENAME, SAL, ROW_NUMBER () OVER(ORDER BY SAL ASC) AS C1
FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER (ORDER BY SAL) AS C1
FROM EMP
WHERE DEPTNO = 20;

--������ �Լ��� ������ ��, ��ȸ�� ��� �����Ͱ� �ƴ� Ư�� ���� ������ ����
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
-- RANGE�� ORDER BY �÷����� ���� id ���� ���� �÷��� ��� ����
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

-- UNBOUNDED PRECEDING : ������ ���� ��ġ�� ù ��° �ο����� �ǹ�
-- UNBOUNDED FOLLOWING : ������ ������ ��ġ�� ������ �ο����� �ǹ�
-- BETWEEN ~ AND : �������� ���۰� �� ��ġ�� ����
-- [ROW��] PRECEDING : ������ ���� ��ġ�� ROW����ŭ ������ ���� �ο����� �ǹ�
-- [ROW��] FOLLOWING : ������ ������ ��ġ�� ROW����ŭ ������ ������ �ο����� �ǹ�
-- CURRENT ROW : ���� �ο������ �ǹ�
-- SAL RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING
-- : SAL������ 50�� ���� 100�� ���� ���� �����찡 ��
-- ��, FORD�� SAL�� 3000�̴ϱ� SAL�� 2950 ~ 3100 �� �÷��� ī��Ʈ��
-- , JONES, SCOTT, FORD�� ī��Ʈ �Ǿ� 3
SELECT EMPNO, ENAME, SAL
,COUNT(*)OVER( ORDER BY SAL RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING) AS C1
FROM EMP 
WHERE DEPTNO = 20;

-- �̷��� ��ȸ�ϸ� SAL��ġ�� �ְ� �� ����
SELECT EMPNO, ENAME, SAL, ROWNUM AS RN
FROM EMP
WHERE DEPTNO IN (20,30)
AND ROWNUM <= 3
ORDER BY SAL DESC;

-- ��ġ�� �ֱ��� ��ȸ �Ϸ���
SELECT A.*
      ,ROWNUM AS RN
 FROM (SELECT EMPNO, ENAME, SAL
        FROM EMP
        WHERE DEPTNO IN (20,30)
        ORDER BY SAL DESC) A
 WHERE ROWNUM <= 3;


-- Top-N Query
-- ���� N���� �����͸� �����ֱ� ���� Top-N Query

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

-- ����¡���� 
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

-- ROW LIMITING : 11G�� �������� �� �ǰ� 12C���� ����

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC OFFSET 3 ROWS;

select * from v$version;

--������ ����
CREATE TABLE BOM (
     ITEM_ID INTEGER NOT NULL, -- ǰ��ĺ���
     PARENT_ID INTEGER, -- ����ǰ�� �ĺ���
     ITEM_NAME VARCHAR2(20) NOT NULL, -- ǰ���̸�
     ITEM_QTY INTEGER, -- ǰ�� ����
     PRIMARY KEY (ITEM_ID)
);

INSERT INTO BOM VALUES ( 1001, NULL, '��ǻ��', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '��ü', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '�����', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '������', 1);

INSERT INTO BOM VALUES ( 1005, 1002, '���κ���', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '��ī��', 1);
INSERT INTO BOM VALUES ( 1007, 1002, '�Ŀ����ö���', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '�׷���ī��', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '��Ÿ��ġ', 1);

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














