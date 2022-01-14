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

-- �ɸ� ���� �ð� 5.38 sec , parse_calls : 10000 / loads : 1 / executions : 10000 / fetches : 10000
DECLARE
  TYPE rc IS REF CURSOR; -- ����Ʈ����, ��ȯ Ÿ���� ���� Ŀ��
  l_rc rc; -- Ŀ���� ���� ���� l_rc, �׷� l_rc���� ���� ������ ����� ���� �޸��� �ּҸ� ��� �ִ°ų�? 
  l_object_name t2_3.object_name%type; -- t2_3 ���̺��� object_name �÷��� ���� Ÿ���� ����
BEGIN
  FOR i IN 1..100000
  loop
    OPEN l_rc FOR --Ŀ�� ���� 
      'SELECT /* choTest1 */ object_name
       FROM t2_3
       WHERE  object_id = :x' USING i;  --object_id 1~100000���� ã��
    FETCH l_rc INTO l_object_name; -- SELECT���� ����� ������ �Űܴ��
    CLOSE l_rc; -- Ŀ�� ����
  END loop; -- ���� ����
end;

SELECT sql_text, parse_calls, loads, executions, fetches
  FROM v$sql
WHERE 1=1
--AND parsing_schema_name = 'edu16'
AND sql_text like '%choTest1%'
AND sql_text not like '%v$sql%'
AND sql_text not like 'declare%'
;


-- ����ð� 55.95 sec // ���� 4733
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