CREATE TABLE t2_3
AS 
SELECT * 
  FROM all_objects;
  
SELECT * 
  FROM t2_3;
 
INSERT INTO t2_3
SELECT * 
  FROM t2_3;
  
UPDATE t2_3 SET object_id = ROWNUM;

CREATE UNIQUE INDEX t2_3_idx ON t2_3(object_id);

EXEC dbms_stats.gather_table_stats('edu16', 't2_3');

-- 걸린 실행 시간 5.38 sec , parse_calls : 10000 / loads : 1 / executions : 10000 / fetches : 10000
DECLARE
  TYPE rc IS REF CURSOR; -- 포인트변수, 반환 타입이 없는 커서
  l_rc rc; -- 커서를 담은 변수 l_rc, 그럼 l_rc에는 쿼리 수행한 결과를 가진 메모리의 주소를 담고 있는거나? 
  l_object_name t2_3.object_name%type; -- t2_3 테이블의 object_name 컬럼과 같은 타입의 변수
BEGIN
  FOR i IN 1..100000
  loop
    OPEN l_rc FOR --커서 오픈 
      'SELECT /* choTest1 */ object_name
       FROM t2_3
       WHERE  object_id = :x' USING i;  --object_id 1~100000까지 찾음
    FETCH l_rc INTO l_object_name; -- SELECT쿼리 결과를 변수에 옮겨담고
    CLOSE l_rc; -- 커서 종료
  END loop; -- 루프 종료
end;

SELECT sql_text, parse_calls, loads, executions, fetches
  FROM v$sql
WHERE 1=1
--AND parsing_schema_name = 'edu16'
AND sql_text like '%choTest1%'
AND sql_text not like '%v$sql%'
AND sql_text not like 'declare%'
;


-- 실행시간 55.95 sec // 실행 4733
DECLARE
  TYPE rc IS REF CURSOR; 
  l_rc rc; 
  l_object_name t2_3.object_name%type; 
BEGIN
  FOR i IN 1..100000
  loop
    OPEN l_rc FOR 
      'SELECT /* choTest2 */ object_name
       FROM t2_3
       WHERE  object_id = ' || i;  
    FETCH l_rc INTO l_object_name; 
    CLOSE l_rc; 
  END loop; 
end;

SELECT sql_text, parse_calls, loads, executions, fetches
  FROM v$sql
WHERE 1=1
--AND parsing_schema_name = 'edu16'
AND sql_text like '%choTest2%'
AND sql_text not like '%v$sql%'
AND sql_text not like 'declare%'
;

SELECT count(*)
  FROM v$sql
WHERE 1=1
--AND parsing_schema_name = 'edu16'
AND sql_text like '%choTest2%'
AND sql_text not like '%v$sql%'
AND sql_text not like 'declare%'
;