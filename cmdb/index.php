<?php
session_start();
if($_SESSION['loggedin'] !== "LOGGED_IN" ){
    header('Location: /index.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="DB Collector DBA Prod">
  <meta name="author" content="clam@luxsapientia.eu">


  <title>SB Admin - Dashboard</title>

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
            <a href="/cmdb">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Overview</li>
        </ol>

        <!-- Icon Cards-->
        <div class="row">
	</div>
<div class="row">

        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white
                                <?php
                                include 'mysql_connect/mysql.php';
                                $sql="SELECT CASE WHEN count(*) = 0 THEN ' bg-success o-hidden h-100\">' ELSE ' bg-warning o-hidden h-100\">' END as 'compliance_result' FROM oracle_security_scoring where admin_high_privs_score=0 or audit_enable_score=0 or default_profile_score=0 or default_user_pwd_score=0 or high_tab_privs_score=0 or security_parameter_score=0 or security_profile_score=0";
                                if ($result=mysqli_query($con,$sql))
                                {
                                        while($row = mysqli_fetch_row($result))
                                        {
                                                foreach($row as $cell)
                                                        echo "$cell";
                                        }
                                mysqli_free_result($result);
                                }
                                mysqli_close($con);
                                ?>
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-list"></i>
                </div>
                <div class="mr-5">Oracle Security Compliance - Infra</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="OracleSecurityCompliance.php">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>


          <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white 
                                <?php
                                include 'mysql_connect/mysql.php';
                                $sql="SELECT CASE WHEN count(*) = 0 THEN ' bg-success o-hidden h-100\">' ELSE ' bg-warning o-hidden h-100\">' END as 'compliance_result' FROM mssql_security_scoring where compliance_score_total < 100";
                                if ($result=mysqli_query($con,$sql))
                                {
                                        while($row = mysqli_fetch_row($result))
                                        {
                                                foreach($row as $cell)
                                                        echo "$cell";
                                        }
                                mysqli_free_result($result);
                                }
                                mysqli_close($con);
                                ?>
              <div class="card-body">
                <div class="card-body-icon">
                  <i class="fas fa-fw fa-list"></i>
                </div>
                <div class="mr-5">MSSQL Security Compliance - Infra</div>
              </div>
              <a class="card-footer text-white clearfix small z-1" href="MSSQLSecurityCompliance.php">
                <span class="float-left">View Details</span>
                <span class="float-right">
                  <i class="fas fa-angle-right"></i>
                </span>
              </a>
            </div>
          </div>


          <div class="col-xl-3 col-sm-6 mb-3">
			  <div class="card text-white
			  <?php
				  include 'mysql_connect/mysql.php';
				  $sql="select CASE WHEN count(lmschk.compliance_result) = 0 THEN ' bg-success o-hidden h-100\">' ELSE ' bg-warning o-hidden h-100\">' END as 'result' FROM (
				  select CASE WHEN num_core=0 Then 'BAD' ELSE 'GOOD' END as 'compliance_result'
				  from oracle_lms lms, oracle_lms_reference lmsref 
				  where lms.product_name=lmsref.product_name
				  and lms.db_name in (select db_name from oracle_database_list where license_type='CPU') 
				  and usage_detected <> 'NO_USAGE'
				  and lmsref.license_type='CPU'
				  UNION ALL
				  select CASE WHEN num_core=0 Then 'BAD' ELSE 'GOOD' END as 'compliance_result'
				  from oracle_lms lms, oracle_lms_reference lmsref 
				  where lms.product_name=lmsref.product_name
				  and lms.db_name in (select db_name from oracle_database_list where license_type='FSIP') 
				  and usage_detected <> 'NO_USAGE'
				  and lmsref.license_type='FSIP') lmschk
				  where lmschk.compliance_result='BAD';";
				  if ($result=mysqli_query($con,$sql))
				  {
					  while($row = mysqli_fetch_row($result))
					  {
						  foreach($row as $cell)
						  echo "$cell";
					  }
					  mysqli_free_result($result);
				  }
				  mysqli_close($con);
				  ?>
				  <div class="card-body">
					  <div class="card-body-icon">
						  <i class="fas fa-fw fa-list"></i>
					  </div>
					  <div class="mr-5">Oracle Licensing Overview</div>
				  </div>
				  <a class="card-footer text-white clearfix small z-1" href="OracleLicensingOverview.php">
					  <span class="float-left">View Details</span>
					  <span class="float-right">
						  <i class="fas fa-angle-right"></i>
					  </span>
				  </a>
			  </div>
          </div>


          <div class="col-xl-3 col-sm-6 mb-3">
                          <div class="card text-white bg-success o-hidden h-100\">
                                  <div class="card-body">
                                          <div class="card-body-icon">
                                                  <i class="fas fa-fw fa-list"></i>
                                          </div>
                                          <div class="mr-5">MSSQL Licensing Overview</div>
                                  </div>
                                  <a class="card-footer text-white clearfix small z-1" href="MSSQLLicensing.php">
                                          <span class="float-left">View Details</span>
                                          <span class="float-right">
                                                  <i class="fas fa-angle-right"></i>
                                          </span>
                                  </a>
                          </div>
          </div>


        </div>

          <div class="row">

	  </div>
		

        <div class="row">
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                Hosts OS</div>
              <div class="card-body">
                <canvas id="HostsOS" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                Oracle DB</div>
              <div class="card-body">
                <canvas id="OracleDB" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                Oracle PDB</div>
              <div class="card-body">
                <canvas id="OraclePDB" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                MSSQL DB</div>
              <div class="card-body">
                <canvas id="MSSQLDB" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                Oracle Version</div>
              <div class="card-body">
                <canvas id="OracleVersion" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                MSSQL Version</div>
              <div class="card-body">
                <canvas id="MSSQLVersion" width="100%" height="100"></canvas>
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
  <script src="vendor/chart.js/Chart.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- JavaScript Chart-->
  <script type="text/javascript">
	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#292b2c';

	// Pie Chart Example
	var ctx = document.getElementById("HostsOS");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["Windows 10.0", "Windows 6.3", "Windows 6.1", "Linux x86 64-bit"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(a.nbhst,',',b.nbhst,',',c.nbhst,',',d.nbhst)
					  from
					  (SELECT count(*) as nbhst FROM mssql_hosts where os_type='10.0') a,
					  (SELECT count(*) as nbhst FROM mssql_hosts where os_type='6.3') b,
                                          (SELECT count(*) as nbhst FROM mssql_hosts where os_type='6.1') c,
					  (SELECT count(*) as nbhst FROM oracle_hosts where os_type='Linux x86 64-bit') d";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>
		  ],
		  backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745'],
		}],
	  },
	});

	var ctx = document.getElementById("OracleDB");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["PRD", "Non PRD"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(a.nbdb,',',b.nbdb)
					  from
					  (SELECT count(distinct db_name) as nbdb FROM `oracle_database_list` where environment='PRD') a,
					  (SELECT count(distinct db_name) as nbdb FROM `oracle_database_list` where environment<>'PRD') b";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>		  
		  ],
		  backgroundColor: ['#007bff', '#dc3545'],
		}],
	  },
	});

	var ctx = document.getElementById("OraclePDB");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["DEV", "TST", "UAT", "PRD"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(a.nbpdb,',',b.nbpdb,',',d.nbpdb,',',g.nbpdb)
from
(SELECT count(distinct pdb_name) as nbpdb FROM oracle_pdbs where pdb_name like 'PDBD%') a,
(SELECT count(distinct pdb_name) as nbpdb FROM oracle_pdbs where pdb_name like 'PDBT%') b,
(SELECT count(distinct pdb_name) as nbpdb FROM oracle_pdbs where pdb_name like 'PDBU%') d,
(SELECT count(distinct pdb_name) as nbpdb FROM oracle_pdbs where pdb_name like 'PDBP%') g";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>		
		  ],
		  backgroundColor: ['#007b4f', '#dc3545', '#007bff', '#ffc107', '#28a745', '#282qs5','#8528ff','#c0c0c0'],
		}],
	  },
	});
	
	var ctx = document.getElementById("OracleVersion");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["19c","23ai"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(d.db_name,',',f.db_name)
					  from		
                                          (SELECT count(db_name) as db_name FROM `oracle_database_list` where db_version='19.0.0.0.0') d,
					  (SELECT count(db_name) as db_name FROM `oracle_database_list` where db_version like '23%') f";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>
		  ],
		  backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745', '#282qs5','#c0c0c0'],
		}],
	  },
	});
 
	var ctx = document.getElementById("MSSQLVersion");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["2008R2", "2012", "2014", "2016", "2017","2019","2022"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(a.product_version,',',b.product_version,',',c.product_version,',',d.product_version,',',e.product_version,',',f.product_version,',',g.product_version)
					  from			
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '10.50.%') a,
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '11.0.%') b,
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '12.0.%') c,
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '13.0.%') d,
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '14.0.%') e,
					  (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '15.0.%') f,
                                          (SELECT count(distinct(hostname)) as product_version FROM mssql_hosts where mssql_product_version like '16.0.%') g";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>	
		  ],
		  backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745','#c0c0c0','#20b7ca','#a1cb58'],
		}],
	  },
	});

	var ctx = document.getElementById("MSSQLDB");
	var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		labels: ["DEV", "PRD","TST","UAT"],
		datasets: [{
		  data: [
		  		<?php
				include 'mysql_connect/mysql.php';
				$sql="select concat(a.mssql_hst,',',d.mssql_hst,',',e.mssql_hst,',',f.mssql_hst)
					  from
					  (SELECT count(hostname) mssql_hst FROM mssql_hosts where env='DEV') a,
					  (SELECT count(hostname) mssql_hst FROM mssql_hosts where env='PRD') d,
					  (SELECT count(hostname) mssql_hst FROM mssql_hosts where env='TST') e,
					  (SELECT count(hostname) mssql_hst FROM mssql_hosts where env='UAT') f";
				if ($result=mysqli_query($con,$sql))
				{
					while($row = mysqli_fetch_row($result))
					{
						foreach($row as $cell)
							echo "$cell";
					}
				mysqli_free_result($result);
				}
				mysqli_close($con);
				?>	
		  ],
		  backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28c845', '#21q745', '#8528ff','#a1cb58'],
		}],
	  },
	});	
  </script>
</body>

</html>
