<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="servlets.ConnectionDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
    
    
<%
		ConnectionDAO con=new ConnectionDAO();
		String uId = (String)session.getAttribute("user_id");
		String branch = (String)session.getAttribute("branch");
		String dept = (String)session.getAttribute("dept");
		
		String dept1=request.getParameter("dept");
		
		Statement statement=con.getConnection();
		ResultSet resultset = statement.executeQuery("SELECT DISTINCT dept,DISPLAY_DEPT FROM OLL.cor_user_permission where USER_ID='" + uId + "'");

		Statement statement1=con.getConnection();
		ResultSet resultset1 = statement1.executeQuery("select a.REPORT_ID, a.DISPLAY_NAME,a.PROCEDURE_NAME from oll.cor_report_master a, OLL.cor_user_permission b where a.DEPARTMENT=b.DEPT and a.REPORT_ID = b.REPORT_ID and a.DEPARTMENT='"+dept1+"' and b.USER_ID='"+uId+"'");

		String rep_id = request.getParameter("report_id");
		
		Statement statement2 = con.getConnection();
		ResultSet resultset2 = statement2
				.executeQuery("SELECT * FROM OLL.cor_report_parameter WHERE REPORT_ID='" + rep_id + "' order by s_no");

		Statement statement3=con.getConnection();
		ResultSet resultset3 = statement3.executeQuery("SELECT (EMP_EMP_TITLE||' '||EMP_FIRST_NAME)NAME FROM OLL.PER_EMP_M WHERE EMP_EMP_CODE ='" + uId + "'");
%> 
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Om Logistics</title>
   <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
  <link href="custom_style.css" rel="stylesheet">
  <link rel="shortcut icon" href="Image/title_icon.ico" />
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="dashboard" title="Om Logistics"><img alt="" src="Image/white_logo.png"></a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
          <a class="nav-link custom_nav-link" href="dashboard">
            <i class="fa fa-fw fa-dashboard"></i>
            <span class="nav-link-text">Dashboard</span>
          </a>
        </li>
       <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Reports">
          <a class="nav-link nav-link-collapse collapsed custom_nav-link" data-toggle="collapse" href="#collapseMulti" data-parent="#exampleAccordion">
            <i class="fa fa-fw fa-area-chart"></i>
            <span class="nav-link-text">Reports</span>
          </a>
          <ul class="sidenav-second-level collapse" id="collapseMulti">
          
          <% 
          while (resultset.next()) { 
          %>
       	<li class="custom_list"><a id="toggleNavPosition" class="custom_nav-link" href="report_menu.jsp?dept=<%=resultset.getString(1)%>"><i class="fa fa-dashboard fa-fw"></i>&nbsp;<%=resultset.getString(2).substring(0, 1).toUpperCase()+resultset.getString(2).substring(1).toLowerCase()%></a>	
		</li>
		<%	} %>
            
           </ul> 
        </li>
      </ul>
      <ul class="navbar-nav sidenav-toggler">
        <li class="nav-item">
          <a class="nav-link text-center" id="sidenavToggler">
            <i class="fa fa-fw fa-angle-left"></i>
          </a>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto">
       <!--Display User Name -->
          <li class="nav-item"><a class="nav-link"><i
                            class="icon-user"></i> <b class="caret">
                            <% while (resultset3.next()) { %>
                            Welcome! <%=resultset3.getString(1)%> 
                             <%	} %> 
                            </b></a>
          </li>
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
        <li class="breadcrumb-item">
          <a href="dashboard.jsp">Dashboard</a>
        </li>
        <li class="breadcrumb-item active"><%= dept1%> Reports Menu</li>
      
      </ol>
      <hr>
      <!--Report Menu Button -->
   	 <div class="row">
   	<%	
   		  int n = 0;
          while (resultset1.next()) { 
          n=n+1;
     %>
   		<div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-info o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-download"></i>
                </div>
               <a class="custom_menu_name" href="report?report_id=<%=resultset1.getString(1)%>&report_name=<%=resultset1.getString(2)%>&dept=<%=dept1%>&procedure=<%=resultset1.getString(3)%>">
              <div><%=n+". "+resultset1.getString(2)%></div></a>
            </div>
            <%-- <a class="card-footer text-white clearfix small z-1" href="report?report_id=<%=resultset1.getString(1)%>&report_name=<%=resultset1.getString(2)%>&dept=<%=dept1%>&procedure=<%=resultset1.getString(3)%>">
              <span class="float-left">Click For Report</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a> --%>
          </div>
        </div>
    <%	} %>
    </div>
      <!--Report Menu Button End -->
  
 
	  <!-- Blank div to give the page height to preview the fixed vs. static navbar-->
      <div style="height: 100px;"></div>
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
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
    <!-- Logout Modal-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="index.jsp">Logout</a>
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
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-charts.min.js"></script>
  </div>
</body>

</html>
