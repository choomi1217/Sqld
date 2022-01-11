-- SELECT deptno,count(*),avg(sal) 
--  FROM scott.emp 
--GROUP BY deptno;

--SELECT /*+ gather_plan_statistics */  * 
-- FROM scott.emp e , scott.dept d
--WHERE d.deptno = e.deptno AND e.sal >= 1000;

--SELECT * 
--FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL,NULL,'ALLSTATS LAST'));

SELECT /*+ gather_plan_statistics */  * 
FROM small_table
WHERE OWNER = 'SYSTEM';

SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL,NULL,'ALLSTATS LAST'));

