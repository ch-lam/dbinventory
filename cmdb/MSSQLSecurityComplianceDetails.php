<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="DB Collector DBA Prod">
  <meta name="author" content="clam@luxsapientia.eu">>

  <title>DB - Collector</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="/cmdb">DB Collector</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
        <?php
                include 'dropdownlist.php';
        ?>
    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
			  <li class="breadcrumb-item active">MSSQL Security Dashboard Details: 
				  <?php echo "<b>" .$_GET["servername"]. "</b>";  ?>
			  </li>
        </ol>
		
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Configuration Options - INFRA -  
		<?php echo "<b>" .$_GET["servername"]. "</b>";  ?>
	  </div>
			<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
					  <th>Parameter Name</th>
					  <th>Parameter Value</th>
					  <th>Compliance Result</th>	
					  <th>Exception Comment</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>			  
					  <th>Parameter Name</th>
					  <th>Parameter Value</th>
					  <th>Compliance Result</th>	
					  <th>Exception Comment</th>
                  </tr>
                </tfoot>
                <tbody>
				<?php
				include 'mysql_connect/mysql.php';
					$sql="SELECT a.name,a.config_value,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
					FROM `mssql_security_configoptions` a, mssql_security_configoptions_exception b
					where a.servername=b.servername
					and a.name=b.name
					and a.config_value=b.config_value
					and a.servername='".$_GET["servername"]."'
					UNION ALL
					SELECT name,config_value,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
					FROM `mssql_security_configoptions` 
					where concat(servername,name,config_value) not in (select concat(servername,name,config_value) from mssql_security_configoptions_exception where servername='".$_GET["servername"]."')
					and servername='".$_GET["servername"]."'";
				if ($result=mysqli_query($con,$sql))
				{
					echo "</tr>\n";
					while($row = mysqli_fetch_row($result))
					{
						echo "<tr>";
						foreach($row as $cell)
							echo "<td><center>$cell</center></td>";
						echo "</tr>\n";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>
                </tbody>
              </table>
            </div>
          </div>
        </div>

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Database Properties - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>";  ?>
			</div>	
			<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>DB Name</th>
									<th>is_auto_close_on</th>
									<th>is_trustworthy_on</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>DB Name</th>
									<th>is_auto_close_on</th>
									<th>is_trustworthy_on</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.db_name,a.is_auto_close_on,a.is_trustworthy_on,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM `mssql_security_dbproperties` a, mssql_security_dbproperties_exception b
									where a.servername=b.servername
									and a.db_name=b.db_name
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT db_name,is_auto_close_on,is_trustworthy_on,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM `mssql_security_dbproperties` 
									where concat(servername,db_name,is_auto_close_on,is_trustworthy_on) not in (select concat(servername,db_name,is_auto_close_on,is_trustworthy_on) from mssql_security_dbproperties_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Encryption - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>DB Name</th>
									<th>Key Type</th>
									<th>Key Name</th>
									<th>Algorythm Description</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>DB Name</th>
									<th>Key Type</th>
									<th>Key Name</th>
									<th>Algorythm Description</th>
									<th>Compliance Result</th>	
									<th>Exception Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.db_name,a.key_type,a.key_name,a.algorithm_desc,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM `mssql_security_encryption` a, mssql_security_encryption_exception b
									where a.servername=b.servername
									and a.db_name=b.db_name
									and a.key_type=b.key_type
									and a.key_name=b.key_name
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT db_name,key_type,key_name,algorithm_desc,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM `mssql_security_encryption` 
									where concat(servername,db_name,key_type,key_name) not in (select concat(servername,db_name,key_type,key_name) from mssql_security_encryption_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Local Builtin groups - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable3" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Local Group Name</th>
									<th>Permission Name</th>
									<th>State Description</th>	
									<th>Compliance Result</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>Local Group Name</th>
									<th>Permission Name</th>
									<th>State Description</th>	
									<th>Compliance Result</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT localgroupname,permission_name,state_desc, replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>') from mssql_security_groups where servername='".$_GET["servername"]."'";
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	


			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Guest Connect - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable4" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>DB Name</th>
									<th>Permission Name</th>
									<th>State Description</th>
									<th>Compliance Result</th>									
									<th>Exception Comment</th>	
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>DB Name</th>
									<th>Permission Name</th>
									<th>State Description</th>
									<th>Compliance Result</th>									
									<th>Exception Comment</th>
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.db_name,a.permission_name,a.state_desc,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_guestconnect a, mssql_security_guestconnect_exception b
									where a.db_name=b.db_name
									and a.permission_name=b.permission_name
									and a.state_desc=b.state_desc
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT db_name,permission_name,state_desc,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_guestconnect 
									where concat(db_name,permission_name,state_desc) not in (select concat(db_name,permission_name,state_desc) from mssql_security_guestconnect_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Logins - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable8" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Login Name</th>
									<th>Principal ID</th>
									<th>is_sysadmin</th>	
									<th>is_policy_checked</th>
									<th>Access Method</th>
									<th>is_expiration_checked</th>
									<th>is_disabled</th>
									<th>Creation Date</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>Login Name</th>
									<th>Principal ID</th>
									<th>is_sysadmin</th>	
									<th>is_policy_checked</th>
									<th>Access Method</th>
									<th>is_expiration_checked</th>
									<th>is_disabled</th>
									<th>Creation Date</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.login_name,a.principal_id,a.is_sysadmin,a.is_policy_checked,a.access_method,a.is_expiration_checked,a.is_disabled,a.create_date,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_logins a, mssql_security_logins_exception b
									where a.servername=b.servername  AND a.login_name=b.login_name
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT login_name,principal_id,is_sysadmin,is_policy_checked,access_method,is_expiration_checked,is_disabled,create_date,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_logins
									where concat(servername,login_name) not in (select concat(servername,login_name) from mssql_security_logins_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	

			
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Orphaned Users - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable5" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>DB Name</th>
									<th>Username</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>DB Name</th>
									<th>Username</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.db_name,a.user_name,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_orphanedusers a, mssql_security_orphanedusers_exception b
									where a.servername=b.servername
									and a.db_name=b.db_name
									and a.user_name=b.user_name
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT db_name,user_name,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_orphanedusers
									where concat(servername,db_name,user_name) not in (select concat(servername,db_name,user_name) from mssql_security_orphanedusers_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	


			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Public Permissions - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable6" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>DB Name</th>
									<th>Username</th>
									<th>Permission Name</th>	
									<th>State Description</th>									
									<th>Compliance Result</th>
									<th>Exception Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>DB Name</th>
									<th>Username</th>
									<th>Permission Name</th>	
									<th>State Description</th>									
									<th>Compliance Result</th>
									<th>Exception Comment</th>
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.db_name,a.username,a.permission_name,a.state_desc,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_publicpermission a, mssql_security_publicpermission_exception b
									where a.servername=b.servername
									and a.db_name=b.db_name
									and a.username=b.username
									and a.state_desc=b.state_desc
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT db_name,username,permission_name,state_desc,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_publicpermission
									where concat(db_name,username,permission_name,state_desc) not in (select concat(db_name,username,permission_name,state_desc) from mssql_security_publicpermission_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'";
									
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	
			

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				Registry Checks - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable7" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Parameter Name</th>
									<th>Value</th>
									<th>Compliance Result</th>	
									<th>Exception Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>Parameter Name</th>
									<th>Value</th>
									<th>Compliance Result</th>	
									<th>Exception Comment</th>		
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.name,a.value,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_registryinfo a, mssql_security_registryinfo_exception b
									where a.servername=b.servername
									and concat(a.servername,a.name) in (select concat(servername,name) from mssql_security_registryinfo_exception where a.servername='".$_GET["servername"]."')
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT name,value,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_registryinfo
									where concat(servername,name) not in (select concat(servername,name) from mssql_security_registryinfo_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'
									";	
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>	
			
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>
				SQL Server Audit - INFRA - 
				<?php echo "<b>" .$_GET["servername"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable9" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Audit Name</th>
									<th>Audit Enabled</th>
									<th>Write Location</th>
									<th>Audit Specification Name</th>
									<th>Audit Specification Enabled</th>
									<th>Audit Action Name</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>Audit Name</th>
									<th>Audit Enabled</th>
									<th>Write Location</th>
									<th>Audit Specification Name</th>
									<th>Audit Specification Enabled</th>
									<th>Audit Action Name</th>
									<th>Compliance Result</th>
									<th>Exception Comment</th>		
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.auditname,a.auditenabled,a.writelocation,a.auditspecificationname,a.auditspecificationenabled,a.auditactionname,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM mssql_security_sqlserveraudit a, mssql_security_sqlserveraudit_exception b
									where a.servername=b.servername
									and a.servername='".$_GET["servername"]."'
									UNION ALL
									SELECT auditname,auditenabled,writelocation,auditspecificationname,auditspecificationenabled,auditactionname,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM mssql_security_sqlserveraudit
									where concat(servername,auditactionname) not in (select concat(servername,auditactionname) from mssql_security_sqlserveraudit_exception where servername='".$_GET["servername"]."')
									and servername='".$_GET["servername"]."'
									";	
									if ($result=mysqli_query($con,$sql))
									{
										echo "</tr>\n";
										while($row = mysqli_fetch_row($result))
										{
											echo "<tr>";
											foreach($row as $cell)
											echo "<td><center>$cell</center></td>";
											echo "</tr>\n";
										}
										mysqli_free_result($result);
									}
									mysqli_close($con);
								?>
							</tbody>
						</table>
					</div>
				</div>
			</div>
      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © DBA</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->
   

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>
  
  <!-- Page level plugin JavaScript-->
  <script src="vendor/chart.js/Chart.min.js"></script>
  
  <!-- CSV scripts for this page-->
  <script src="vendor/csv/csv.js"></script>

  <!-- JavaScript AreaChart-->
</body>

</html>
