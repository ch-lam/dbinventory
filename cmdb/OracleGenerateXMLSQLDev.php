<?php
echo "{\"connections\":";
echo "<br>";
echo "[";
echo "<br>";
include 'mysql_connect/mysql.php';
$sql="select concat('{\"name\":\"',a.service_name,'\",\"type\":\"jdbc\",\"info\":{\"role\":\"\",\"SavePassword\":\"false\",\"OracleConnectionType\":\"TNS\",\"RaptorConnectionType\":\"Oracle\",\"customUrl\":\"',a.service_name,'\",\"oraDriverType\":\"thin\",\"NoPasswordConnection\":\"TRUE\",\"driver\":\"oracle.jdbc.OracleDriver\",\"subtype\":\"oraJDBC\",\"OS_AUTHENTICATION\":\"false\",\"user\":\"administrator\",\"KERBEROS_AUTHENTICATION\":\"false\",\"ConnName\":\"',a.service_name,'\"}},')
from (select distinct service_name  from oracle_jdbc_tns) a
union all
select concat('{\"name\":\"EMPTY\",\"type\":\"jdbc\",\"info\":{\"role\":\"\",\"SavePassword\":\"false\",\"OracleConnectionType\":\"TNS\",\"RaptorConnectionType\":\"Oracle\",\"customUrl\":\"EMPTY\",\"oraDriverType\":\"thin\",\"NoPasswordConnection\":\"TRUE\",\"driver\":\"oracle.jdbc.OracleDriver\",\"subtype\":\"oraJDBC\",\"OS_AUTHENTICATION\":\"false\",\"user\":\"administrator\",\"KERBEROS_AUTHENTICATION\":\"false\",\"ConnName\":\"EMPTY\"}}') from dual;";

if ($result=mysqli_query($con,$sql))
{
	while($row = mysqli_fetch_row($result))
	{
		foreach($row as $cell)
			echo "$cell";
			echo "<br>";
	}
mysqli_free_result($result);
}
mysqli_close($con);
echo "]";
echo "<br>";
echo "}";
?>
