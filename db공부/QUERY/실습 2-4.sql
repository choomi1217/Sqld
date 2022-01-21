SELECT *
FROM (
  SELECT parsing_schema_name, sql_id, sql_text, executions
       , SUM(executions) OVER (PARTITION BY force_matching_signature ) executions_sum
       , ROW_NUMBER() OVER (PARTITION BY force_matching_signature ORDER BY sql_id DESC) rnum
       , COUNT(*) OVER (PARTITION BY force_matching_signature ) cnt
       , force_matching_signature
  FROM   gv$sqlarea s
  WHERE  force_matching_signature != 0
  --  AND parsing_schema_name = 'edu16'
)
WHERE  cnt > 5
-- AND    rnum = 1
ORDER BY cnt DESC, sql_text
?;

SELECT * FROM DUAL;

SELECT ROWID, DBMS_ROWID.ROWID_BLOCK_NUMBER(ROWID) BLOCK_NO , DUMMY
FROM DUAL;

SELECT SYSDATE
FROM DUAL;

SELECT * FROM V$PARAMETER
WHERE NAME LIKE '%optimizer_mode%';








