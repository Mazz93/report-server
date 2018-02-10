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
		String report_name=request.getParameter("report_name");
		String procedure=request.getParameter("procedure");
		
		Statement statement=con.getConnection();
		ResultSet resultset = statement.executeQuery("SELECT DISTINCT dept,DISPLAY_DEPT FROM OLL.cor_user_permission where USER_ID='" + uId + "'");

		Statement statement1=con.getConnection();
		ResultSet resultset1 = statement1.executeQuery("select a.REPORT_ID, a.DISPLAY_NAME,a.PROCEDURE_NAME from oll.cor_report_master a, OLL.cor_user_permission b where a.DEPARTMENT=b.DEPT and a.REPORT_ID = b.REPORT_ID and a.DEPARTMENT='"+dept1+"' and b.USER_ID='"+uId+"'");

		String rep_id = request.getParameter("report_id");
		
		Statement statement2 = con.getConnection();
		ResultSet resultset2 = statement2
				.executeQuery("SELECT REPORT_ID,PARAM_NAME,PARAM_TYPE, CASE  WHEN PARAM_TYPE = 'date' THEN TO_CHAR(trunc(Sysdate),'yyyy-mm-dd')  WHEN PARAM_NAME= 'BRANCH CODE' THEN '1306'   WHEN PARAM_NAME = 'COMPANY CODE' THEN '400001' ELSE PARAM_NAME  END  para_value   FROM OLL.cor_report_parameter   WHERE REPORT_ID='" + rep_id + "' ORDER BY S_NO");
				
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
  <link rel="stylesheet" media="all" href="ispinner.prefixed.css" />
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
          <a href="dashboard">Dashboard</a>
          <li class="breadcrumb-item active"><a href="report_menu.jsp?dept=<%= dept1%>"><%= dept1%> Reports Menu</a></li>
      
        </li>
        <li class="breadcrumb-item active"><%= report_name%></li>
      </ol>
      <hr>
   
    <!-- Modal -->
   <%--  <div class="container">
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <h5 class="modal-title">Report Parameter</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
        <div class="modal-body">
          <form action="AssetsRep" method="Post">
					<div class="col-lg-6">
						<%
							while (resultset2.next()) {
						%>
						<div class="form-group">
							<%=resultset2.getString(2)%>&nbsp;&nbsp;<input class="form-control" required type="<%=resultset2.getString(3)%>" name="<%=resultset2.getString(2)%>">
		<%=resultset2.getString(2)%>
		<input class="form-control" required type="<%=resultset2.getString(3)%>" 
		name="<%=resultset2.getString(2)%>">
						</div>
						<%
							}
						%>

						<input type="submit" name="submit" value="Download" /> 
					</div>
				</form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
       </div>
    </div>
  </div> --%>
  <!-- Modal -->
  
  <!-- Parameter Form -->
  <div class="custom_form" align="center">
  	<form action="<%=procedure%>" method="Post">
 					<div class="col-lg-4">
						<%	Statement statementC=con.getConnection();
						    ResultSet resultsetC = null;
							String company = "";
						    String branchlist = "";
						    String tmode = "";
						    String frmode = "";
						    String dt = "";
							while (resultset2.next()) {
							company = resultset2.getString(2);
							branchlist = resultset2.getString(2);
							tmode = resultset2.getString(2);
							frmode= resultset2.getString(2);
							dt= resultset2.getString(3);
							
						%>
						<div class="form-group">
						<% if(company.equals("COMPANY CODE")){
							resultsetC = statementC.executeQuery("SELECT distinct COMPANY_COMPANY_CODE,COMPANY_NAME FROM OLL.COR_COMPANY_M order by COMPANY_COMPANY_CODE");
						%>
					<div class="div"><%=resultset2.getString(2)%></div><select name="COMPANY CODE" class="form-control custom_form_control" >
						  		<option value="*">---All Company---</option>
						  <% while(resultsetC.next()){ %>
						  		<option value="<%=resultsetC.getString(1)%>"><%=resultsetC.getString(1)+"-"+resultsetC.getString(2)%></option>
						  <% } %>
						
						</select>
						<% }
						else if(branchlist.equals("BRANCH CODE")){
							resultsetC = statementC.executeQuery("SELECT distinct BRANCH_BRANCH_CODE,BRANCH_BRANCH_NAME FROM OLL.COR_BRANCH_M order by BRANCH_BRANCH_CODE");
						%>
					<div class="div"><%=resultset2.getString(2)%></div>	<select name="BRANCH CODE" class="form-control custom_form_control" >
						  <option value="*">---All Branch---</option>
						  <% while(resultsetC.next()){ %>
						  		<option value="<%=resultsetC.getString(1)%>"><%=resultsetC.getString(1)+"-"+resultsetC.getString(2)%></option>
						  <% } %>
						</select>
						<% }	
						else if(tmode.equals("TRANSPORT MODE")){
							resultsetC = statementC.executeQuery("SELECT DISTINCT SYSCDS_CODE_VALUE VALUE,SYSCDS_CODE_DESC T_MODE FROM OLL.COR_SYSCODES WHERE SYSCDS_CODE_TYPE ='OPS_MODE' ORDER BY SYSCDS_CODE_VALUE");
						%>
						<div class="div"><%=resultset2.getString(2)%></div><select name="TRANSPORT MODE" class="form-control custom_form_control" >
						  <option value="*">---All Transport Mode---</option>
						  <% while(resultsetC.next()){ %>
						  		<option value="<%=resultsetC.getString(1)%>"><%=resultsetC.getString(2)%></option>
						  <% } %>
						</select>
						<% }
						 else if(frmode.equals("FREIGHT MODE")){
							resultsetC = statementC.executeQuery("SELECT DISTINCT SYSCDS_CODE_VALUE VALUE,SYSCDS_CODE_DESC FR_MODE FROM OLL.COR_SYSCODES WHERE SYSCDS_CODE_TYPE ='OPS_FRE_MODE' ORDER BY SYSCDS_CODE_VALUE");
						%>
						<div class="div"><%=resultset2.getString(2)%></div><select name="FREIGHT MODE" class="form-control custom_form_control" >
						 <option value="*">---All Freight Mode---</option>
						  <% while(resultsetC.next()){ %>
						  		<option value="<%=resultsetC.getString(1)%>"><%=resultsetC.getString(2)%></option>
						  <% } %>
						</select>
						<% } 
						 else if(dt.equals("date")){
							%>
							<div class="div"><%=resultset2.getString(2)%></div><input required class="form-control custom_form_control" 
						 value="<%=resultset2.getString(4)%>" 
						type="<%=resultset2.getString(3)%>" 
						name="<%=resultset2.getString(2)%>">
						
							<% }
						 else { %>
						<div class="div"><%=resultset2.getString(2)%></div><input required class="form-control custom_form_control" 
						value="*" 
						placeholder="<%=resultset2.getString(2)%>"  
						type="<%=resultset2.getString(3)%>" 
						name="<%=resultset2.getString(2)%>">
						<% } %>
						</div>
						<% } %>
						<input type="submit" name="submit" class="btn btn-info waves-effect waves-light col s12"  value="Download" data-toggle="modal" data-target="#myModal"/>
					</div>
				</form>
				
	</div>			
	<!-- End Parameter Form -->
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
    <!-- Loader script -->
    <script type="text/javascript">	
     $('.btn').on('click', function() {
        var $this = $(this);
    setTimeout(function() {
       $this.button('');
   }, 8000);
});
</script>
    <!-- Loader sceipt end -->
  </div>
  <!--lOADER -->
  
<div class="container">
 
 <!--  <button type="button"  data-toggle="modal" data-target="#myModal">Open Modal</button> -->

  <!-- Modal -->
    
  <div class="modal fade" id="myModal" role="dialog">
      <!-- Modal content-->
<p style="text-align : center; bottom :100px;">          	
  
 <div class="ispinner ispinner--gray ispinner--animating">
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
    <div class="ispinner__blade"></div>
  </div>
</p>
 </div>
  </div>
  <!-- lOADER eND -->
</body>

</html>
