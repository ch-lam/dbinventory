<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="DB Collector DBA Prod">
  <meta name="author" content="clam@luxsapientia.eu">

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
			  <li class="breadcrumb-item active">Oracle Security Dashboard Details: 
				  <?php
					  echo "<b>" .$_GET["db_name"]. "</b>";
				  ?>
			  </li>
        </ol>
		
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            SQLNET Encryption (sqlnet.ora Config File) - INFRA -
            <?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
         </div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable10" width="100%" cellspacing="0">
                <thead>
                  <tr>
                                          <th>Encryption SQLNet</th>
                                          <th>Encryption Value</th>
                                          <th>Compliance Result</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                                          <th>Encryption SQLNet</th>
                                          <th>Encryption Value</th>
                                          <th>Compliance Result</th>
                  </tr>
                </tfoot>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
                                        $sql="SELECT 'SQL Net Encryption Method',a.sqlnet_encryption,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>')
					      FROM oracle_security_network_encryption a
                                              where a.db_name='".$_GET["db_name"]."'";
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
            DB Parameters (Parameter File) - INFRA -
	    <?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
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
					  <th>Comment</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>			  
					<th>Parameter Name</th>
					<th>Parameter Value</th>
					<th>Compliance Result</th>	
                    <th>Comment</th>
                  </tr>
                </tfoot>
                <tbody>
				<?php
				include 'mysql_connect/mysql.php';
					$sql="SELECT a.parameter_name,a.parameter_value,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
					FROM `oracle_security_parameter` a, oracle_security_parameter_exception b
					where a.db_name=b.db_name
					and a.parameter_name=b.parameter_name
					and a.parameter_value=b.parameter_value
					and a.db_name='".$_GET["db_name"]."'
					UNION ALL
					SELECT parameter_name,parameter_value,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
					FROM `oracle_security_parameter` 
					where concat(db_name,parameter_name,parameter_value) not in (select concat(db_name,parameter_name,parameter_value) from oracle_security_parameter_exception where db_name='".$_GET["db_name"]."')
					and db_name='".$_GET["db_name"]."'";
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
				Audit Activated - INFRA -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Audit</th>
									<th>Compliance Result</th>	
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Audit</th>
									<th>Compliance Result</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT pdb_name,audit_parameter, replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>') from oracle_security_audit_enable where db_name='".$_GET["db_name"]."'";
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
				User Default Password - INFRA -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Username</th>
									<th>Compliance Result</th>	
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Username</th>
									<th>Compliance Result</th>		
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT pdb_name,username, replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>') from oracle_security_default_user_pwd where db_name='".$_GET["db_name"]."'";
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
				DB Profile Definition - INFRA -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable3" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Profile</th>
									<th>Resource Name</th>	
									<th>Resource Value</th>
									<th>Compliance Result</th>
									<th>Comment</th>
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Profile</th>
									<th>Resource Name</th>	
									<th>Resource Value</th>
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.pdb_name,a.profile,a.resource_name,a.limit_value,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_profile a, oracle_security_profile_exception b
									where a.db_name=b.db_name
									and a.profile=b.profile
									and a.resource_name=b.resource_name
									and a.limit_value=b.limit_value
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT pdb_name,profile,resource_name,limit_value,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_profile 
									where concat(db_name,pdb_name,profile,resource_name,limit_value) not in (select concat(pdb_name,profile,resource_name,limit_value) from oracle_security_profile_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'";
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
				Users PasswordFile - INFRA -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable4" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Username</th>
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>Username</th>
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.username,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_admin_high_privs a, oracle_security_admin_high_privs_exception b
									where a.db_name=b.db_name
									and a.username=b.username
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT username,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_admin_high_privs 
									where concat(db_name,username) not in (select concat(db_name,username) from oracle_security_admin_high_privs_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'";
									
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
				Users With Default Profile - INFRA -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable8" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Username</th>
									<th>Profile</th>	
									<th>Compliance Result</th>
									<th>Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Username</th>
									<th>Profile</th>	
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.pdb_name,a.username,a.profile,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_default_profile a, oracle_security_default_profile_exception b
									where a.db_name=b.db_name
									and a.pdb_name=b.pdb_name
									and a.username=b.username
									and a.profile=b.profile
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT pdb_name,username,profile,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_default_profile
									where concat(db_name,pdb_name,username,profile) not in (select concat(db_name,pdb_name,username,profile) from oracle_security_default_profile_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'";
									
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
                                Encrypted TableSpace State - INFRA -
                                <?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
                                </div>
                                <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
                                <div class="card-body">
                                        <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable9" width="100%" cellspacing="0">
                                                        <thead>
                                                                <tr>
                                                                        <th>DB Name</th>
                                                                        <th>PDB Name</th>
                                                                        <th>Tablespace Name</th>
                                                                        <th>Encrypted</th>
                                                                        <th>Compliance Result</th>
                                                                </tr>
                                                        </thead>
                                                        <tfoot>
                                                                <tr>
                                                                        <th>DB Name</th>
                                                                        <th>PDB Name</th>
                                                                        <th>Tablespace Name</th>
                                                                        <th>Encrypted</th>
                                                                        <th>Compliance Result</th>
                                                                </tr>
                                                        </tfoot>
                                                        <tbody>
                                                                <?php
                                                                        include 'mysql_connect/mysql.php';
                                                                        $sql="SELECT db_name,pdb_name,tablespace_name,encrypted,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>')
                                                                        FROM oracle_security_tablespace_encrypted
                                                                        where db_name='".$_GET["db_name"]."'";

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
				High Role Privs -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable5" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.pdb_name,a.username,a.privilege,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_high_role_privs a, oracle_security_high_role_privs_exception b
									where a.db_name=b.db_name
									and a.pdb_name=b.pdb_name
									and a.username=b.username
									and a.privilege=b.privilege
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT pdb_name,username,privilege,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_high_role_privs
									where concat(db_name,pdb_name,username,privilege) not in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_role_privs_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'";
									
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
				High Sys Privs -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable6" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.pdb_name,a.username,a.privilege,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_high_sys_privs a, oracle_security_high_sys_privs_exception b
									where a.db_name=b.db_name
									and a.pdb_name=b.pdb_name
									and a.username=b.username
									and a.privilege=b.privilege
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT pdb_name,username,privilege,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_high_sys_privs
									where concat(db_name,pdb_name,username,privilege) not in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_sys_privs_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'";
									
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
				High Tab Privs -
				<?php echo "<b>" .$_GET["db_name"]. "</b>"; ?>
				</div>
				<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable7" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>		
								</tr>
							</thead>
							<tfoot>
								<tr>			  
									<th>PDB Name</th>
									<th>Username</th>
									<th>Privilege</th>	
									<th>Compliance Result</th>
									<th>Comment</th>	
								</tr>
							</tfoot>
							<tbody>
								<?php
									include 'mysql_connect/mysql.php';
									$sql="SELECT a.pdb_name,a.username,a.privilege,replace(replace(a.compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),b.comment as 'Exception'
									FROM oracle_security_high_tab_privs a, oracle_security_high_tab_privs_exception b
									where a.db_name=b.db_name
									and a.pdb_name=b.pdb_name
									and a.username=b.username
									and a.privilege=b.privilege
									and a.db_name='".$_GET["db_name"]."'
									UNION ALL
									SELECT pdb_name,username,privilege,replace(replace(compliance_score,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),'No exception set' as 'Exception'
									FROM oracle_security_high_tab_privs
									where concat(db_name,pdb_name,username,privilege) not in (select concat(db_name,pdb_name,username,privilege) from oracle_security_high_tab_privs_exception where db_name='".$_GET["db_name"]."')
									and db_name='".$_GET["db_name"]."'
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
