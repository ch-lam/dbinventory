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
          <li class="breadcrumb-item active">MSSQL Security Dashboard</li>
        </ol>

		<!-- Area Chart Example-->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Compliance Security PROD Result %</div>
          <div class="card-body">
            <canvas id="AreaChartPROD" width="100%" height="30"></canvas>
          </div>
        </div>

        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            Compliance Security NON_PROD Result %</div>
          <div class="card-body">
            <canvas id="AreaChartNONPROD" width="100%" height="30"></canvas>
          </div>
        </div>
		
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Security Scoring Per Servername</div>
			<button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
					  <th>Legacy Server</th>
					  <th>Exception Detected</th>
					  <th>Compliance Result %</th>
					  <th>Scoring Date</th>
					  <th>Details</th>	
					  <th>Servername</th>
					  <th>Environment</th>
					  <th>ConfigOptions (Infra)</th>
					  <th>DB Properties (Infra)</th>
					  <th>Audit Level (Infra)</th>
					  <th>Encryption (Infra)</th>
					  <th>Builtin/Local Groups (Infra)</th>
					  <th>Guest Connect (Infra)</th>
					  <th>Logins (Infra)</th>
					  <th>Orphaned Users (Infra)</th>
					  <th>Public Permission (Infra)</th>
					  <th>Registry Settings (Infra)</th>
					  <th>SQL Server Audit (Infra)</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>			  
                                          <th>Legacy Server</th>
                                          <th>Exception Detected</th>
					  <th>Compliance Result %</th>
					  <th>Scoring Date</th>
					  <th>Details</th>	
					  <th>Servername</th>
					  <th>Environment</th>
					  <th>ConfigOptions (Infra)</th>
					  <th>DB Properties (Infra)</th>
					  <th>Audit Level (Infra)</th>
					  <th>Encryption (Infra)</th>
					  <th>Builtin/Local Groups (Infra)</th>
					  <th>Guest Connect (Infra)</th>
					  <th>Logins (Infra)</th>
					  <th>Orphaned Users (Infra)</th>
					  <th>Public Permission (Infra)</th>
					  <th>Registry Settings (Infra)</th>
					  <th>SQL Server Audit (Infra)</th>
                  </tr>
                </tfoot>
                <tbody>
				<?php
				include 'mysql_connect/mysql.php';
		$sql="SELECT 
replace(replace(legacy_server,'1','<font color=\"orange\">YES</font>'),0,'<font color=\"green\">NO</font>'),
replace(replace(exception_detected,'1','<font color=\"orange\">YES</font>'),0,'<font color=\"green\">NO</font>'),
compliance_score_total,
date_value,
concat('<a href=\"MSSQLSecurityComplianceDetails.php?servername=',servername,'\">Details</a>'),
servername,
environment,
replace(replace(configoptions,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(dbproperties,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(auditlevel,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(encryption,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(groups,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(guestconnect,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(logins,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(orphanedusers,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(publicpermission,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(registryinfo,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>'),
replace(replace(sqlserveraudit,'1','<font color=\"green\">OK</font>'),0,'<font color=\"red\">NOK</font>')
from mssql_security_scoring";
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
  <script type="text/javascript">
	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#292b2c';

	// Area Chart Example
	var ctx = document.getElementById("AreaChartPROD");
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
                <?php
                        echo "labels: [\"".date('F',  strtotime("-6 month"))."\", \"".date('F',  strtotime("-5 month"))."\", \"".date('F',  strtotime("-4 month"))."\", \"".date('F',  strtotime("-3 month"))."\", \"".date('F',  strtotime("-2 month"))."\", \"".date('F',  strtotime("-1 month"))."\", \"".date("F")."\"],";
                ?>
		datasets: [{
		  label: "Average Security Scoring %",
		  lineTension: 0.3,
		  backgroundColor: "rgba(2,117,216,0.2)",
		  borderColor: "rgba(2,117,216,1)",
		  pointRadius: 5,
		  pointBackgroundColor: "rgba(2,117,216,1)",
		  pointBorderColor: "rgba(255,255,255,0.8)",
		  pointHoverRadius: 5,
		  pointHoverBackgroundColor: "rgba(2,117,216,1)",
		  pointHitRadius: 50,
		  pointBorderWidth: 2,
		  data: [
			<?php
				include 'mysql_connect/mysql.php';
				$sql="SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total) from
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
				(SELECT avg(compliance_score_total) as 'compliance_score_total' FROM `mssql_security_scoring` where environment='PRD') g";
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
		}],
	  },
	  options: {
		scales: {
		  xAxes: [{
			time: {
			  unit: 'date'
			},
			gridLines: {
			  display: false
			},
			ticks: {
			  maxTicksLimit: 7
			}
		  }],
		  yAxes: [{
			ticks: {
			  min: 0,
			  max: 100,
			  maxTicksLimit: 5
			},
			gridLines: {
			  color: "rgba(0, 0, 0, .125)",
			}
		  }],
		},
		legend: {
		  display: false
		}
	  }
	});	
    </script>

  <script type="text/javascript">
	// Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#292b2c';

	// Area Chart Example
	var ctx = document.getElementById("AreaChartNONPROD");
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
		<?php
			echo "labels: [\"".date('F',  strtotime("-6 month"))."\", \"".date('F',  strtotime("-5 month"))."\", \"".date('F',  strtotime("-4 month"))."\", \"".date('F',  strtotime("-3 month"))."\", \"".date('F',  strtotime("-2 month"))."\", \"".date('F',  strtotime("-1 month"))."\", \"".date("F")."\"],";
		?>
		datasets: [{
		  label: "Average Security Scoring %",
		  lineTension: 0.3,
		  backgroundColor: "rgba(2,117,216,0.2)",
		  borderColor: "rgba(2,117,216,1)",
		  pointRadius: 5,
		  pointBackgroundColor: "rgba(2,117,216,1)",
		  pointBorderColor: "rgba(255,255,255,0.8)",
		  pointHoverRadius: 5,
		  pointHoverBackgroundColor: "rgba(2,117,216,1)",
		  pointHitRadius: 50,
		  pointBorderWidth: 2,
		  data: [
			<?php
				include 'mysql_connect/mysql.php';
				$sql="SELECT concat(a.compliance_score_total,',',b.compliance_score_total,',',c.compliance_score_total,',',d.compliance_score_total,',',e.compliance_score_total,',',f.compliance_score_total,',',g.compliance_score_total) from 
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH))) a,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH))) b,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH))) c,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))) d,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH))) e,
                                (SELECT CASE WHEN avg(compliance_score_total) is NULL Then '0' ELSE avg(compliance_score_total) END as 'compliance_score_total' FROM `mssql_security_history` where environment='PRD' and  MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))) f,
				(SELECT avg(compliance_score_total) as 'compliance_score_total' FROM `mssql_security_scoring` where environment!='PRD') g";
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
		}],
	  },
	  options: {
		scales: {
		  xAxes: [{
			time: {
			  unit: 'date'
			},
			gridLines: {
			  display: false
			},
			ticks: {
			  maxTicksLimit: 7
			}
		  }],
		  yAxes: [{
			ticks: {
			  min: 0,
			  max: 100,
			  maxTicksLimit: 5
			},
			gridLines: {
			  color: "rgba(0, 0, 0, .125)",
			}
		  }],
		},
		legend: {
		  display: false
		}
	  }
	});	
    </script>
</body>

</html>
