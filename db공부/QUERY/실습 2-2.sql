CREATE TABLE t1 ( a NUMBER, b VARCHAR2(100) ) ;
CREATE TABLE t2 ( a NUMBER, b VARCHAR2(100) ) ;
CREATE TABLE t3 ( a NUMBER, b VARCHAR2(100) ) ;
CREATE TABLE t4 ( a NUMBER, b VARCHAR2(100) ) ;
CREATE TABLE t5 ( a NUMBER, b VARCHAR2(100) ) ;

-- JOIN 순서를 ORDERED 로 지정 >>> 실행 완료. Time used: 13469 Millis
DECLARE
     l_cnt NUMBER;
BEGIN 
     FOR i IN 1..10000
     loop
          EXECUTE IMMEDIATE ' SELECT /*+ ORDERED */ COUNT(*) ' || 
                                              ' FROM t1, t2, t3, t4, t5 ' || 
                                              ' WHERE t1.a = ' || i || 
                                              ' AND t2.a = ' || i ||
                                              ' AND t3.a = ' || i ||
                                              ' AND t4.a = ' || i ||
                                              ' AND t5.a = ' || i INTO l_cnt;
     END loop;
END;


-- JOIN 순서 미지정 >> 실행 완료. Time used: 28758 Millis.
DECLARE
     l_cnt NUMBER;
BEGIN 
     FOR i IN 1..10000
     loop
          EXECUTE IMMEDIATE ' SELECT COUNT(*) ' || 
                                              ' FROM t1, t2, t3, t4, t5 ' || 
                                              ' WHERE t1.a = ' || i || 
                                              ' AND t2.a = ' || i ||
                                              ' AND t3.a = ' || i ||
                                              ' AND t4.a = ' || i ||
                                              ' AND t5.a = ' || i INTO l_cnt;
     END loop;
END;





