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

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item active">Oracle Release Support</li>
	  <li class="breadcrumb-item active">
	  <?php echo " " . date("Y-m-d h:m") . ""; ?>
	  </li>
        </ol>


          <div class="row">
	  </div>


        <!-- DataTables Example -->

       <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
             Oracle Infrastructure Release Used</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>TYPE</th>
                    <th>VERSION</th>
                    <th>END_OF_SUPPORT_DATE</th>
                    <th>SUPPORT</th>
                  </tr>
                </thead>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
                                $sql="select TYPE,VERSION,END_OF_SUPPORT_DATE,
				CASE
        			WHEN END_OF_SUPPORT_DATE >  CURDATE() THEN '<font color=\"green\">SUPPORTED</font>'
        			ELSE '<font color=\"red\">OUT OF SUPPORT</font>'
        			END as 'supported_state'
				from product_support where TYPE='ORACLE'
				UNION ALL
				SELECT 'ORACLE',db_version,'NOT REGISTER IN CMDB','<font color=\"red\">OUT OF SUPPORT</font>' from oracle_database_list
				where db_version not in (select version from product_support where TYPE='ORACLE')";
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
             PDB Infrastructure Support State</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
                <thead>
                  <tr>
		    <th>ENV</th>
                    <th>APP</th>
                    <th>VERSION</th>
                    <th>SUPPORT</th>
                    <th>PDB_NAME</th>
                  </tr>
                </thead>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
				$sql="SELECT distinct CASE
        WHEN substr(a.pdb_name,4,1) = 'D' THEN 'DEV'
        WHEN substr(a.pdb_name,4,1) = 'T' THEN 'TST'
        WHEN substr(a.pdb_name,4,1) = 'V' THEN 'INT'
        WHEN substr(a.pdb_name,4,1) = 'U' THEN 'UAT'
        WHEN substr(a.pdb_name,4,1) = 'P' THEN 'PRD'
        WHEN substr(a.pdb_name,4,1) = 'A' THEN 'TAT'
        WHEN substr(a.pdb_name,4,1) = 'R' THEN 'DRE'
        WHEN substr(a.pdb_name,4,1) = 'S' THEN 'SNAPSHOT'
        ELSE 'UNKNOWN'
        END as 'env'
,substr(a.pdb_name,6,30),b.db_version,
CASE
        WHEN b.db_version in (select VERSION from product_support where TYPE='ORACLE' AND END_OF_SUPPORT_DATE <  CURDATE()) THEN '<font color=\"red\">OUT OF SUPPORT</font>'
        ELSE '<font color=\"green\">SUPPORTED</font>'
        END as 'supported_state'
,a.pdb_name FROM oracle_pdbs a, oracle_database_list b
where a.instance_name=b.instance_name
order by 2,1,3";
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
             Non Container Infrastructure Support State</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable5" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>ENV</th>
                    <th>VERSION</th>
                    <th>DB_NAME</th>
                    <th>SUPPORT</th>
                  </tr>
                </thead>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
				$sql="select x.environment, x.db_version, x.db_name,x.supported_state from (SELECT distinct a.db_name,  a.environment
,a.db_version,
CASE
        WHEN a.db_version in (select VERSION from product_support where TYPE='ORACLE' AND END_OF_SUPPORT_DATE <  CURDATE()) THEN '<font color=\"red\">OUT OF SUPPORT</font>'
        ELSE '<font color=\"green\">SUPPORTED</font>'
        END as 'supported_state'
		FROM oracle_database_list a
		where a.database_type='NON_CONTAINER'
		and db_role='PRIMARY'
order by 2,1,3) x";
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
  <script type="text/javascript">
        // Set new default font family and font color to mimic Bootstrap's default styling
        Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
        Chart.defaults.global.defaultFontColor = '#292b2c';

        // Pie Chart Example

    </script>

</body>

</html>
