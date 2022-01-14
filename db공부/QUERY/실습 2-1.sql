-- DUAL ���̺��� 50 ������ �����͵� ����
SELECT ROWNUM no 
FROM DUAL CONNECT BY LEVEL <= 50 ;

--
CREATE TABLE t 
AS 
SELECT d.no , e.*
FROM scott.emp e
          , ( SELECT ROWNUM no 
               FROM DUAL CONNECT BY LEVEL <= 1000 ) d ;
               
--
SELECT * FROM t ;

--
CREATE INDEX t_x01 ON t(deptno, no);
CREATE INDEX t_x02 ON t(deptno, job, no);

--
-- DBMS_STATS.GATHER_TABLE_STATS( �����̸�, ���̺�� ) : �����̸��� ���̺�� ��������� ����
-- ��� �������� ������Ʈ ���� �ý��� ��谡 ����, ������Ʈ�� ���̺�, �ε���,  �÷��� ����

EXEC DBMS_STATS.GATHER_TABLE_STATS( 'edu16', 't' ); --���̺� ������
EXEC DBMS_STATS.GATHER_INDEX_STATS('edu16','t_x01');  --�ε��� ������
EXEC DBMS_STATS.GATHER_TABLE_STATS('edu16','t',CASCADE=TRUE);  --���̺�,�ε��� ���ü���
EXEC DBMS_STATS.GATHER_TABLE_STATS('scott','emp',CASECADE=FALSE, METHOD_OPT='for columns ename size 10, deptno size 4'); --������׷� ����

-- ������ ���̺� ��������� ��ȸ�ϴ� ���� / all_tab_statistics �信���� ���� ���� Ȯ�ΰ���
-- ���̸���.. ���� ���̺��̶� ��䰡???
 SELECT num_rows, blocks, avg_row_len, sample_size, last_analyzed
  FROM all_tables
WHERE owner = 'scott' AND table_name='emp';

 SELECT num_rows, blocks, avg_row_len, sample_size, last_analyzed
  FROM all_tables
WHERE owner = 'edu16' AND table_name='t';

 SELECT endpoint_value, endpoint_number
  FROM all_histograms
WHERE owner = 'scott'
             AND table_name = 'emp'
             AND column_name = 'deptno'
ORDER BY endpoint_value;  

SELECT * FROM all_tab_statistics;

--

 SELECT * 
  FROM t
WHERE deptno = 10 
            AND no = 1 ;

/* INDEX (t t_x02) : t���̺� t_x0 �ε����� ���� */
/* NO_INDEX_SS(t) : ��ŵ ��ĵ(ss)�� ������ �ٸ� ����������� ���� */
 SELECT /*+INDEX(t t_x02) NO_INDEX_SS(t) */  *
  FROM t 
WHERE deptno = 10 
             AND NO = 1;

 SELECT /*+ FULL(t) */ * 
  FROM t
WHERE deptno = 10 
             AND NO = 1; 

--
 SELECT /*+ GATHER_PLAN_STATISTICS 0mi */ *
  FROM scott.dept, scott.emp;
  
 SELECT * 
  FROM V$SQL
WHERE sql_text LIKE '%0mi%';














