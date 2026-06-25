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
          <li class="breadcrumb-item active">Oracle Databases</li>
        </ol>
		
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Oracle Databases List</div>
			<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>Hostname</th>
                    <th>Instance Name</th>
                    <th>Version</th>
					<th>DB Name</th>
                    <th>DB Type</th>
                    <th>PDB Count</th>
                    <th>Log Mode</th>
                    <th>Role</th>
                    <th>Charset</th>
                    <th>Edition</th>
                    <th>RAC</th>
                    <th>DB Unique Name</th>
					<th>Environment</th>
					<th>Oracle License</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>Hostname</th>
                    <th>Instance Name</th>
                    <th>Version</th>
					<th>DB Name</th>
                    <th>DB Type</th>
                    <th>PDB Count</th>
                    <th>Log Mode</th>
                    <th>Role</th>
                    <th>Charset</th>
                    <th>Edition</th>
                    <th>RAC</th>
                    <th>DB Unique Name</th>
					<th>Environment</th>
					<th>Oracle License</th>
                  </tr>
                </tfoot>
                <tbody>
				<?php
				include 'mysql_connect/mysql.php';
				$sql="SELECT hostname,instance_name,db_version,db_name,database_type,count_pdb,db_log_mode,db_role,db_charset,db_edition,rac_state,db_unique_name,environment,license_type FROM oracle_database_list order by hostname,instance_name";
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
