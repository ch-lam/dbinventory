declare  @MYSN VARCHAR(100);
DECLARE server_cursor CURSOR FOR select servername from mssql_security_scoring;
DECLARE done INT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN server_cursor;
server_loop: LOOP
   FETCH server_cursor INTO SN;
   IF done THEN
      LEAVE server_loop;
   END IF;
   SELECT servername,compliance_score_total from mssql_security_scoring where servername=@SN;
END LOOP;
  
CLOSE server_cursor;
