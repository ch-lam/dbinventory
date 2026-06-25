<?php
include 'mysql_connect/mysql.php';
$sql="select distinct a.tns from (select concat(upper(service_name),'=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=',primary_hst,')(PORT=',tcp_port,'))(CONNECT_DATA=(SERVICE_NAME=',service_name,')))') as tns
from oracle_jdbc_tns 
where tcp_port <> '1601' 
and tcp_port <> '1613' 
and tcp_port <> '1530'
and service_name not like 'PDB%'
UNION ALL
select concat(upper(service_name),'=(DESCRIPTION_LIST = (FAILOVER = ON)(LOAD_BALANCE = OFF)(DESCRIPTION =(CONNECT_TIMEOUT = 20)(ADDRESS = (PROTOCOL = TCP)(HOST = ',primary_hst,')(PORT = ',tcp_port,'))(CONNECT_DATA = (SERVICE_NAME = ',service_name,')))(DESCRIPTION =(CONNECT_TIMEOUT = 20)(RETRY_COUNT = 2)(ADDRESS = (PROTOCOL = TCP)(HOST = ',standby_hst,')(PORT = ',tcp_port,'))(CONNECT_DATA = (SERVICE_NAME = ',service_name,'))))') as tns
from oracle_jdbc_tns
where standby_hst <> 'EMPTY' 
and service_name not like 'PDB%'
and tcp_port in (1601,1613,1530)) a order by tns";

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
?>
