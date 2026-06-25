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
          <li class="breadcrumb-item active">Oracle Capacity Planning</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
             Oracle Database Usage (Collect J-1 for the day)</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
                <thead>
                  <tr>
		    <th>Cluster/Hostname</th>
                    <th>Environment</th>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Size GB</th>
                    <th>SUM Cpu Time(Min)</th>
                    <th>AVG SGA Usage(Mb)</th>
                    <th>AVG PGA Usage(Mb)</th>
                    <th>AVG Buffer Cache Usage(Mb)</th>
                    <th>AVG Shared Pool Usage(Mb)</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>Cluster/Hostname</th>
                    <th>Environment</th>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Size GB</th>
                    <th>SUM Cpu Time(Min)</th>
                    <th>AVG SGA Usage(Mb)</th>
                    <th>AVG PGA Usage(Mb)</th>
                    <th>AVG Buffer Cache Usage(Mb)</th>
                    <th>AVG Shared Pool Usage(Mb)</th>
                  </tr>
                </tfoot>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
				$sql="select b.hostname,a.environment,db_name,pdb_name,
round(a.size_mb/1024),
a.cpu_time_minutes,
a.avg_sga_mb,avg_pga_mb,
a.avg_buffer_cache_mb,
a.avg_shared_pool_mb
from oracle_database_capacity_planning_summary a,
(SELECT distinct db_name as 'database_name',
CASE
        WHEN hostname like '%vm01%' THEN 'Cluster1'
        WHEN hostname like '%vm02%' THEN 'Cluster2'
	WHEN hostname like '%vm03%' THEN 'Cluster3'
        WHEN hostname like '%vm04%' THEN 'Cluster4'
	WHEN hostname like '%vm04%' THEN 'Cluster4'
        WHEN hostname like '%odak%' THEN 'ODA Kayl'
        WHEN hostname like '%odaw%' THEN 'ODA Windhoff'
    ELSE hostname
    END as 'hostname' FROM oracle_database_list) b
where a.db_name=b.database_name";
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
             TOP 50 DB Size Grows (In last 3 Months)</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable5" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>Size(GB) 3 months ago</th>
                    <th>Current Size(GB)</th>
                    <th>Grows(GB) in 3 months</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>Size(GB) 3 months ago</th>
                    <th>Current Size(GB)</th>
                    <th>Grows(GB) in 3 months</th>
                  </tr>
                </tfoot>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
				$sql="select * from (
select a.db_name,a.pdb_name,b.environment,a.size_gb as min_size,b.size_gb as current_size,b.size_gb-a.size_gb as gb_grows from
(select min(c.date_value),c.db_name,c.pdb_name,c.environment,c.size_gb from (
SELECT DATE_FORMAT(date_value,'%m%d') as date_value,db_name,pdb_name,environment,round(sum(size_mb)/1024) as size_gb
FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)>MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH))
group by db_name,pdb_name,environment,date_value) c
group by c.db_name,c.pdb_name) a,
(SELECT db_name,pdb_name,environment,round(sum(size_mb)/1024) as size_gb
FROM oracle_database_capacity_planning_dbsize group by db_name,pdb_name,environment) b
where a.pdb_name=b.pdb_name
and a.db_name = b.db_name
order by gb_grows) d group by d.db_name,d.pdb_name
order by d.gb_grows desc limit 50";
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
             TOP 20 PDB Cpu usage (Last 3 Months)</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable3" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>AVG Cpu Time(Min) per Day</th>
		    <th>AVG Core per Day</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>AVG Cpu Time(Min) per Day</th>
		    <th>AVG Core per Day</th>
                  </tr>
                </tfoot>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
                                $sql="SELECT pdb_name,environment,round(avg(cpu_time_minutes)) as cpu_time, round(avg(cpu_time_minutes))/60/2
FROM oracle_database_capacity_planning_cpu_mem_history where MONTH(date_value)>MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) 
group by pdb_name,environment
order by cpu_time desc LIMIT 20";

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
             TOP 50 DB DBSize/Segments Size</div>
                        <button onclick="exportTableToCSV('extract.csv')">Export To CSV File</button>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable6" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>Size(GB)</th>
                    <th>Segments Size(GB)</th>
                    <th>Size(GB) - SegmentSize(GB)</th>
                    <th>% Diff</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>DB Name</th>
                    <th>PDB Name</th>
                    <th>Environment</th>
                    <th>Size(GB)</th>
                    <th>Segments Size(GB)</th>
                    <th>Size(GB) - SegmentSize(GB)</th>
                    <th>% Diff</th>
                  </tr>
                </tfoot>
                <tbody>
                                <?php
                                include 'mysql_connect/mysql.php';
                                $sql="select db_name,pdb_name,environment,round(sum(size_mb)/1024),round(sum(sum_segment_mb)/1024),round(sum(size_mb)/1024-sum(sum_segment_mb)/1024),100-round((sum(sum_segment_mb)*100)/sum(size_mb)) from oracle_database_capacity_planning_dbsize where db_name not like 'ZDLRA%' and tablespace_name not like '%UNDO%' group by db_name,pdb_name,environment order by 6 desc LIMIT 50";
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


        <!-- Area Chart Example-->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            PROD - Cumulative DBSize History (GB)</div>
          <div class="card-body">
            <canvas id="AreaChartPRODDBSize" width="100%" height="30"></canvas>
          </div>
        </div>

        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            NONPROD - Cumulative DBSize History (GB)</div>
          <div class="card-body">
            <canvas id="AreaChartNONPRODDBSize" width="100%" height="30"></canvas>
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
        var ctx = document.getElementById("AreaChartPRODDBSize");
        var myLineChart = new Chart(ctx, {
          type: 'line',
          data: {
                <?php
                        echo "labels: [\"".date('F',  strtotime("-6 month"))."\", \"".date('F',  strtotime("-5 month"))."\", \"".date('F',  strtotime("-4 month"))."\", \"".date('F',  strtotime("-3 month"))."\", \"".date('F',  strtotime("-2 month"))."\", \"".date('F',  strtotime("-1 month"))."\", \"".date("F")."\"],";
                ?>
                datasets: [{
                  label: "Cumulative DBSize History GB",
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
                                $sql="SELECT concat(round(a.size_gb),',',round(b.size_gb),',',round(c.size_gb),',',round(d.size_gb),',',round(e.size_gb),',',round(f.size_gb),',',round(g.size_gb)) from
(SELECT COALESCE(h.size_gb,0) as size_gb, min(h.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) h) a,
(SELECT COALESCE(i.size_gb,0) as size_gb, min(i.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) i) b,
(SELECT COALESCE(j.size_gb,0) as size_gb, min(j.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) j) c,
(SELECT COALESCE(k.size_gb,0) as size_gb, min(k.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) k) d,
(SELECT COALESCE(l.size_gb,0) as size_gb, min(l.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) l) e,
(SELECT COALESCE(m.size_gb,0) as size_gb, min(m.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) and environment='PRD' group by DATE_FORMAT(date_value,'%d')) m) f,
(SELECT sum(size_mb)/1024 as size_gb FROM oracle_database_capacity_planning_dbsize where environment='PRD') g";
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
                          max: 15000,
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

        var ctx = document.getElementById("AreaChartNONPRODDBSize");
        var myLineChart = new Chart(ctx, {
          type: 'line',
          data: {
                <?php
                        echo "labels: [\"".date('F',  strtotime("-6 month"))."\", \"".date('F',  strtotime("-5 month"))."\", \"".date('F',  strtotime("-4 month"))."\", \"".date('F',  strtotime("-3 month"))."\", \"".date('F',  strtotime("-2 month"))."\", \"".date('F',  strtotime("-1 month"))."\", \"".date("F")."\"],";
                ?>
                datasets: [{
                  label: "Cumulative DBSize History GB",
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
                                $sql="SELECT concat(round(a.size_gb),',',round(b.size_gb),',',round(c.size_gb),',',round(d.size_gb),',',round(e.size_gb),',',round(f.size_gb),',',round(g.size_gb)) from
(SELECT COALESCE(h.size_gb,0) as size_gb, min(h.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) h) a,
(SELECT COALESCE(i.size_gb,0) as size_gb, min(i.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) i) b,
(SELECT COALESCE(j.size_gb,0) as size_gb, min(j.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) j) c,
(SELECT COALESCE(k.size_gb,0) as size_gb, min(k.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) k) d,
(SELECT COALESCE(l.size_gb,0) as size_gb, min(l.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) l) e,
(SELECT COALESCE(m.size_gb,0) as size_gb, min(m.date_value) from (SELECT sum(size_mb)/1024 as size_gb,DATE_FORMAT(date_value,'%d') as date_value FROM oracle_database_capacity_planning_dbsize_history where MONTH(date_value)=MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) and environment<>'PRD' group by DATE_FORMAT(date_value,'%d')) m) f,
(SELECT sum(size_mb)/1024 as size_gb FROM oracle_database_capacity_planning_dbsize where environment<>'PRD') g";
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
                          max: 15000,
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
