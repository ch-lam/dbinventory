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
          </li>
          <li class="breadcrumb-item active">MSSQL Servers with no App databases</li>
        </ol>
		
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            List of MSSQL Servers without App databases</div>
			<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>Hostname</th>
                    <th>Environment</th>
                    <th>Edition</th>
					<th>Product Version</th>
                    <th>Collation</th>
                    <th>OS Type</th>
                    <th>Is Clustered</th>
                    <th>VCpu</th>
                    <th>Memory</th>
                    <th>Service Account</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>Hostname</th>
                    <th>Environment</th>
                    <th>Edition</th>
					<th>Product Version</th>
                    <th>Collation</th>
                    <th>OS Type</th>
                    <th>Is Clustered</th>
                    <th>VCpu</th>
                    <th>Memory</th>
                    <th>Service Account</th>
                  </tr>
                </tfoot>
                <tbody>
				<?php
				include 'mysql_connect/mysql.php';
				$sql="SELECT 
	CT.hostname,
	CT.env as Env,
	CASE 
		WHEN CT.mssql_edition like '%Enterprise%' Then 'Enterprise Edition' 
		WHEN CT.mssql_edition like '%Standard%' Then 'Standard Edition' 
		WHEN CT.mssql_edition like '%Express%' Then 'Express Edition'
                WHEN CT.mssql_edition like '%Dev%' Then 'Developer Edition'
		ELSE 'Not Standard Nor Enterprise' END as MSSQL_Edition,
	CT.mssql_product_version,
	CT.collation,
	CT.os_type,
	CT.is_clustered,
	CT.num_cpus,
	CT.memory_gb,
	CT.service_account 
FROM mssql_hosts CT 
where CT.hostname not in (select distinct hostname from mssql_database where database_name not in ('master','model','msdb','tempdb','dba')) order by CT.hostname";
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
