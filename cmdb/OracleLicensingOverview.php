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
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Oracle Licensing Overview</li>
        </ol>

		  <!-- DataTables VCPU Usage -->
		  <div class="card mb-3">
			  <div class="card-header">
				  <i class="fas fa-table"></i>
			  Oracle Licensing Core Usage </div>
			  <div class="card-body">
				  <div class="table-responsive">
					  <table class="table table-bordered" id="dataTable4" width="100%" cellspacing="0">
						  <thead>
							  <tr>
								  <th>License Type</th>
								  <th>OS Type</th>
								  <th>VCPU</th>
								  <th>Core</th>
								  <th>Core (With Core Factor)</th>
							  </tr>
						  </thead>
						  <tfoot>
							  <tr>
								  <th>License Type</th>
								  <th>OS Type</th>
								  <th>VCPU</th>
								  <th>Core</th>
								  <th>Core (With Core Factor)</th>
							  </tr>
						  </tfoot>
						  <tbody>
							  <?php
								  include 'mysql_connect/mysql.php';
								  $sql="select license_type,os_type, sum(num_cpus) as vcpu, 
								  CASE WHEN os_type='Linux x86 64-bit' Then  format(sum(num_cpus)/2,0) ELSE format(sum(num_cpus)/8,0) END as 'num_core',
								  CASE WHEN os_type='Linux x86 64-bit' Then format((sum(num_cpus)/2)/2,0) ELSE format(sum(num_cpus)/8,0) END as 'core_with_core_factor'
								  from oracle_hosts where license_type in ('CPU','FSIP') group by os_type,license_type order by 1,2;";
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
		  
		  <!-- DataTables Product Usage -->
		  <div class="card mb-3">
			  <div class="card-header">
				  <i class="fas fa-table"></i>
			  Oracle Licensing Options Usage </div>
			  <div class="card-body">
				  <div class="table-responsive">
					  <table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
						  <thead>
							  <tr>
								  <th>Product Name</th>
							  	  <th>Compliance Result</th>
							  	  <th>License Type</th>
								  <th>Detected Usage</th>
								  <th>CHL Contract Core/Options</th>
							  </tr>
						  </thead>
						  <tfoot>
							  <tr>
								  <th>Product Name</th>
							  	  <th>Compliance Result</th>
							  	  <th>License Type</th>
								  <th>Detected Usage</th>
								  <th>CHL Contract Core/Options</th>
							  </tr>
						  </tfoot>
						  <tbody>
							  <?php
								  include 'mysql_connect/mysql.php';
								  $sql="select distinct lms.product_name,
								  CASE WHEN num_core=0 Then '<font color=\"red\">BAD</font>' ELSE '<font color=\"green\">GOOD</font>' END as 'compliance_result',
								  'CPU','YES',lmsref.num_core 
								  from oracle_lms lms, oracle_lms_reference lmsref 
								  where lms.product_name=lmsref.product_name
								  and lms.db_name in (select db_name from oracle_database_list where license_type='CPU') 
								  and usage_detected <> 'NO_USAGE'
								  and lmsref.license_type='CPU'
								  UNION ALL
								  select distinct lms.product_name,
								  CASE WHEN num_core=0 Then '<font color=\"red\">BAD</font>' ELSE '<font color=\"green\">GOOD</font>' END as 'compliance_result',
								  'FSIP','YES',lmsref.num_core 
								  from oracle_lms lms, oracle_lms_reference lmsref 
								  where lms.product_name=lmsref.product_name
								  and lms.db_name in (select db_name from oracle_database_list where license_type='FSIP') 
								  and usage_detected <> 'NO_USAGE'
								  and lmsref.license_type='FSIP';";
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

		  <!-- DataTables Oracle Licencing Details -->
		  <div class="card mb-3">
			  <div class="card-header">
				  <i class="fas fa-table"></i>
			  Oracle Licensing Product Usage Details </div>
			  <div class="card-body">
				  <div class="table-responsive">
					  <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						  <thead>
							  <tr>
							  	  <th>Compliance Result</th>
							  	  <th>License Type</th>
								  <th>DB Name</th>
								  <th>Hostname</th>
								  <th>DB/PDB Name</th>
								  <th>Product Name</th>
								  <th>Usage Detected</th>
								  <th>First Usage Date</th>
								  <th>Last Usage Date</th>
							  </tr>
						  </thead>
						  <tfoot>
							  <tr>
							  	  <th>Compliance Result</th>
							  	  <th>License Type</th>
								  <th>DB Name</th>
								  <th>Hostname</th>
								  <th>DB/PDB Name</th>
								  <th>Product Name</th>
								  <th>Usage Detected</th>
								  <th>First Usage Date</th>
								  <th>Last Usage Date</th>
							  </tr>
						  </tfoot>
						  <tbody>
							  <?php
								  include 'mysql_connect/mysql.php';
								  $sql="select '<font color=\"red\">BAD</font>', dbs.license_type, lms.db_name,lms.hostname,lms.db_pdb_name,lms.product_name,lms.usage_detected,lms.first_usage_date,lms.last_usage_date from oracle_lms lms,oracle_database_list dbs 
								  where dbs.db_name=lms.db_name
								  and lms.product_name in (select product_name from oracle_lms_reference where num_core=0 and license_type=dbs.license_type) 
								  and lms.usage_detected<>'NO_USAGE'
								  UNION ALL
								  select '<font color=\"green\">GOOD</font>', dbs.license_type, lms.db_name,lms.hostname,lms.db_pdb_name,lms.product_name,lms.usage_detected,lms.first_usage_date,lms.last_usage_date from oracle_lms lms,oracle_database_list dbs 
								  where dbs.db_name=lms.db_name
								  and lms.product_name in (select product_name from oracle_lms_reference where num_core>0 and license_type=dbs.license_type) 
								  and lms.usage_detected<>'NO_USAGE'";
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
	
	<!-- CSV scripts for this page-->
	<script src="vendor/csv/csv.js"></script>
</body>
	
</html>
