-- DUAL 테이블에서 50 이하인 데이터들 셀렉
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
-- DBMS_STATS.GATHER_TABLE_STATS( 유저이름, 테이블명 ) : 유저이름의 테이블로 통계정보를 수집
-- 통계 정보에는 오브젝트 통계와 시스템 통계가 있음, 오브젝트엔 테이블, 인덱스,  컬럼이 존재

EXEC DBMS_STATS.GATHER_TABLE_STATS( 'edu16', 't' ); --테이블 통계수집
EXEC DBMS_STATS.GATHER_INDEX_STATS('edu16','t_x01');  --인덱스 통계수집
EXEC DBMS_STATS.GATHER_TABLE_STATS('edu16','t',CASCADE=TRUE);  --테이블,인덱스 동시수집
EXEC DBMS_STATS.GATHER_TABLE_STATS('scott','emp',CASECADE=FALSE, METHOD_OPT='for columns ename size 10, deptno size 4'); --히스토그램 수집

-- 수집된 테이블 통계정보를 조회하는 쿼리 / all_tab_statistics 뷰에서도 같은 정보 확인가능
-- 뷰이면은.. 가상 테이블이란 얘긴가???
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

/* INDEX (t t_x02) : t테이블 t_x0 인덱스를 유도 */
/* NO_INDEX_SS(t) : 스킵 스캔(ss)을 제외한 다른 엑세스방법을 유도 */
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














