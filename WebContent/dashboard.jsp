<%@page import="servlets.ConnectionDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Om Logisticss</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- Bootstrap core CSS-->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">
<link href="custom_style.css" rel="stylesheet">
<link rel="shortcut icon" href="Image/title_icon.ico" />
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<%
		if (session==null) {
			response.sendRedirect("index.jsp");
		}

		ConnectionDAO con = new ConnectionDAO();
		String uId = (String) session.getAttribute("user_id");
		String branch = (String) session.getAttribute("branch");
		String dept = (String) session.getAttribute("dept");

		Statement statement = con.getConnection();
		ResultSet resultset = statement.executeQuery(
				"SELECT DISTINCT dept,DISPLAY_DEPT FROM OLL.cor_user_permission where USER_ID='" + uId + "'");

		Statement statement1 = con.getConnection();
		ResultSet resultset1 = statement1.executeQuery(
				"SELECT BRANCH_BRANCH_CODE, BRANCH_BRANCH_NAME, BRANCH_CNTRL_BRANCH_CODE,(BRANCH_BRANCH_ADDR1||' '||BRANCH_BRANCH_ADDR2||' '||BRANCH_BRANCH_ADDR3) ADDRESS,STATE_GST_PROVISIONAL_NO FROM oll.cor_branch_m, oll.cor_state_m WHERE BRCH_STATE_CODE=STATE_STATE_CODE(+)");

		Statement statement2 = con.getConnection();
		ResultSet resultset2 = statement2.executeQuery(
				"SELECT (EMP_EMP_TITLE||' '||EMP_FIRST_NAME)NAME FROM OLL.PER_EMP_M WHERE EMP_EMP_CODE ='" + uId
						+ "'");

		Statement statement3 = con.getConnection();
		ResultSet resultset3 = statement3.executeQuery(
				"SELECT COUNT(c.emp_EMP_CODE) TOTAL_EMP FROM OLL.PER_EMP_M c WHERE  C.EMP_TYPE_CODE=1 and EMP_LVNG_DATE is null AND C.EMP_EMP_CODE NOT BETWEEN 70000 AND 80000");

		Statement statement4 = con.getConnection();
		ResultSet resultset4 = statement4.executeQuery("SELECT sum(TOTAL) FROM  oll.RPT_FA_OUT_DASHBOARD");

		Statement statement5 = con.getConnection();
		ResultSet resultset5 = statement5.executeQuery(
				"select round(sum(BILL_TOTAL)/10000000) from oll.ops_bill_m where to_char(nvl(BILL_MANUAL_DATE,BILL_BILL_DATE),'MM-YYYY')=TO_CHAR(sysdate,'MM-YYYY')");

		Statement statement6 = con.getConnection();
		ResultSet resultset6 = statement6.executeQuery(
				"select round(sum(CN_CHARGED_WEIGHT)/1000) Wt_ton from oll.ops_cn_m c,oll.ops_cn_d d where to_char(nvl(CN_MAMUAL_CN_DATE,cn_cn_DATE),'MM-YYYY')=TO_CHAR(sysdate,'MM-YYYY') and c.cn_cn_no=d.cn_cn_no");

		Statement statement7 = con.getConnection();
		ResultSet resultset7 = statement7.executeQuery(
				"select  sum(SURFACE)sur,sum(EXPRESS)exp, sum(TRAIN)tr, sum(AIR)air from oll.temp_sales_rept");

		Statement statement8 = con.getConnection();
		ResultSet resultset8 = statement8.executeQuery(
				"select PERIOD,sum(TOTAL/1000) from oll.temp_sales_rept group by  PERIOD order by period");

		Statement statement9 = con.getConnection();
		ResultSet resultset9 = statement9.executeQuery(
				"select PERIOD,sum(TOTAL/1000)Total from oll.temp_sales_rept group by  PERIOD order by period");
	%>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
		id="mainNav">
		<a class="navbar-brand" href="dashboard" title="Om Logistics"><img
			alt="" src="Image/white_logo.png"></a>
		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
				<li class="nav-item" data-toggle="tooltip" data-placement="right"
					title="Dashboard"><a class="nav-link custom_nav-link"
					href="dashboard"> <i class="fa fa-fw fa-dashboard"></i> <span
						class="nav-link-text">Dashboard</span>
				</a></li>
				<li class="nav-item" data-toggle="tooltip" data-placement="right"
					title="Reports"><a
					class="nav-link nav-link-collapse collapsed custom_nav-link"
					data-toggle="collapse" href="#collapseMulti"
					data-parent="#exampleAccordion"> <i
						class="fa fa-fw fa-area-chart"></i> <span class="nav-link-text">Reports</span>
				</a>
					<ul class="sidenav-second-level collapse" id="collapseMulti">

						<%
							while (resultset.next()) {
						%>
						<li class="custom_list"><a id="toggleNavPosition"
							class="custom_nav-link"
							href="report_menu.jsp?dept=<%=resultset.getString(1)%>"><i
								class="fa fa-dashboard fa-fw"></i>&nbsp;<%=resultset.getString(2).substring(0, 1).toUpperCase()
						+ resultset.getString(2).substring(1).toLowerCase()%></a></li>
						<%
							}
						%>

					</ul></li>
			</ul>
			<ul class="navbar-nav sidenav-toggler">
				<li class="nav-item"><a class="nav-link text-center"
					id="sidenavToggler"> <i class="fa fa-fw fa-angle-left"></i>
				</a></li>
			</ul>
			<ul class="navbar-nav ml-auto">
				<!--Display User Name -->
				<li class="nav-item"><a class="nav-link"><i
						class="icon-user"></i> <b class="caret"> <%
 	while (resultset2.next()) {
 %> Welcome! <%=resultset2.getString(1)%> <%
 	}
 %>
					</b></a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="modal"
					data-target="#exampleModal"> <i class="fa fa-fw fa-sign-out"></i>Logout
				</a></li>
				<!--Display User Name end-->
			</ul>
		</div>
	</nav>
	<div class="content-wrapper">
		<div class="container-fluid">
			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a>
				</li>
				<li class="breadcrumb-item active">My Dashboard</li>
			</ol>
			<!-- Icon Cards-->
			<div class="row">
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-primary o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fa fa-fw fa-comments"></i>
							</div>
							<div class="mr-5">
								<%
									while (resultset3.next()) {
								%>
								<strong><%=resultset3.getString(1)%></strong>
								<%
									}
								%>
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1"> <span
							class="float-left">Man-Power Strength</span> <span
							class="float-right"> </span>
						</a>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-warning o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fa fa-fw fa-list"></i>
							</div>
							<div class="mr-5">
								<%
									while (resultset5.next()) {
								%>
								<strong><%=resultset5.getString(1)%></strong>
								<%
									}
								%>
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1" href="#">
							<span class="float-left">Total Billing In Current Month</span> <span
							class="float-right"> </span>
						</a>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-success o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fa fa-fw fa-shopping-cart"></i>
							</div>
							<div class="mr-5">
								<%
									while (resultset4.next()) {
								%>
								<strong><%=resultset4.getString(1)%></strong>
								<%
									}
								%>
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1" href="#">
							<span class="float-left">Total Outstanding Crore</span> <span
							class="float-right"> </span>
						</a>
					</div>
				</div>
				<div class="col-xl-3 col-sm-6 mb-3">
					<div class="card text-white bg-danger o-hidden h-100">
						<div class="card-body">
							<div class="card-body-icon">
								<i class="fa fa-fw fa-support"></i>
							</div>
							<div class="mr-5">
								<%
									while (resultset6.next()) {
								%>
								<strong><%=resultset6.getString(1)%></strong>
								<%
									}
								%>
							</div>
						</div>
						<a class="card-footer text-white clearfix small z-1" href="#">
							<span class="float-left">Total Booking Wt In Current Month</span>
							<span class="float-right"> </span>
						</a>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-lg-8">
					<!-- Example Bar Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-bar-chart"></i> <strong> Booking Bar
								Chart Period & Wt. Wise (17-18)</strong>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-8 my-auto">
									<!--  <div id="top_x_div" width="100" height="50"></div> -->
									<canvas id="myBarChart" width="100" height="50"></canvas>
								</div>
								<div class="col-sm-4 text-center my-auto">
									<div class="h4 mb-0 text-primary">Rs.92934,693</div>
									<div class="small text-muted">Yearly Revenue</div>
									<hr>
									<div class="h4 mb-0 text-warning">Rs.9918,474</div>
									<div class="small text-muted">Yearly Expenses</div>
									<hr>
									<div class="h4 mb-0 text-success">Rs.93916,219</div>
									<div class="small text-muted">Yearly Margin</div>
								</div>
							</div>
						</div>
						<div class="card-footer small text-muted">Updated yesterday
							at 11:59 PM</div>
					</div>
				</div>
				<div class="col-lg-4">
					<!-- Example Pie Chart Card-->
					<div class="card mb-3">
						<div class="card-header">
							<i class="fa fa-pie-chart"></i> <strong> Booking Pie
								Chart Wt. Wise (17-18)</strong>
						</div>
						<div class="card-body">
							<canvas id="myPieChart" width="100%" height="100"></canvas>
						</div>
						<div class="card-footer small text-muted">Updated yesterday
							at 11:59 PM</div>
					</div>
					<!-- Example Notifications Card-->
				</div>
			</div>
			<!-- Area Chart Example-->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fa fa-area-chart"></i> <strong> Booking Line
						Chart Period & Wt. Wise (17-18)</strong>
				</div>
				<div class="card-body">
					<canvas id="myAreaChart" width="100%" height="30"></canvas>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at
					11:59 PM</div>
			</div>
			<!-- Example DataTables Card-->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fa fa-table"></i> <strong>All India Branch Data
						Table</strong>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>Bcode</th>
									<th>Bname</th>
									<th>Controlling</th>
									<th>Address</th>
									<th>GSTIN No</th>
								</tr>
							</thead>
							<tbody>
								<%
									while (resultset1.next()) {
								%>
								<tr>
									<td><%=resultset1.getString(1)%></td>
									<td><%=resultset1.getString(2)%></td>
									<td><%=resultset1.getString(3)%></td>
									<td><%=resultset1.getString(4)%></td>
									<td><%=resultset1.getString(5)%></td>

								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at
					11:59 PM</div>
			</div>
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<footer class="sticky-footer">
			<div class="container">
				<div class="text-center">
					<small>Copyright © Thakur Powered by Om Logistics Ltd.</small>
				</div>
			</div>
		</footer>
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		<!-- Logout Modal-->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="Logout">Logout</a>
					</div>
				</div>
			</div>
		</div>
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

		<!-- Custom scripts for this page-->
		<script src="js/sb-admin-datatables.min.js"></script>


		<!--PieChart Script -->
		<script type="text/javascript">
    var ctx = document.getElementById("myPieChart");
    var myPieChart = new Chart(ctx, {
      type: 'pie',
      data: {
        labels: ["Surface", "Express", "Train", "Air"],
        datasets: [{
        	 <%while (resultset7.next()) {%>
          data: [<%=resultset7.getString(1)%>,<%=resultset7.getString(2)%>,<%=resultset7.getString(3)%>, <%=resultset7.getString(4)%>],
     	 <%}%>
          backgroundColor: ['#dc3545', '#28a745', '#ffc107','#007bff'],
          hoverBackgroundColor: ["#ff0000", "#00cc00", " #ffcc00", "#0000ff"]
        }],
      },
    });
    </script>
		<!--PieChart Script End -->

		<!--Bar Chart Script Start -->

		<script type="text/javascript">
	 var ctx = document.getElementById("myBarChart");
	 var label1=[];
	 var data1=[];
	 <%while (resultset8.next()) {%>
	 label1.push("<%=resultset8.getString(1)%>");
	 data1.push(<%=resultset8.getString(2)%>);
	 <%}%>
	 var myLineChart = new Chart(ctx, {
	   type: 'bar',
	   data: {
	     labels: label1,
	     datasets: [{
	       label: "Total Wt. In Ton",
	       backgroundColor: "rgba(2,117,216,1)",
	       borderColor: "rgba(2,117,216,1)",
	       data: data1,
	     }],
	   },
	   options: {
	     legend: {
	       display: false
	     }
	   }
	 });
	</script>

		<!--Bar Chart Script End -->

		<!--Line Chart Script Start -->
		<script type="text/javascript">
var ctx = document.getElementById("myAreaChart");
var label1=[];
var data1=[];
<%while (resultset9.next()) {%>
label1.push("<%=resultset9.getString(1)%>");
data1.push(<%=resultset9.getString(2)%>);
<%}%>
var myLineChart = new Chart(ctx, {
	
  type: 'line',
  
  data: {
	  labels: label1,
    datasets: [{
      label: "Total Wt. In Ton",
      lineTension: 0.3,
      backgroundColor: "rgba(2,117,216,0.2)",
      borderColor: "rgba(2,117,216,1)",
      pointRadius: 5,
      pointBackgroundColor: "rgba(2,117,216,1)",
      pointBorderColor: "rgba(255,255,255,0.8)",
      pointHoverRadius: 5,
      pointHoverBackgroundColor: "rgba(2,117,216,1)",
      pointHitRadius: 20,
      pointBorderWidth: 2,
  data:data1,
    }],
  },
  options: {
    legend: {
      display: false
    }
  }
});
</script>
		<!--Line Chart Script End -->
	</div>

</body>

</html>
