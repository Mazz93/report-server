package servlets;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PR_SALARY_REGISTER")
public class PR_SALARY_REGISTER extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String compcode = request.getParameter("COMPANY CODE");
		String emptype = request.getParameter("EMPLOYEE TYPE");
		String bcode = request.getParameter("BRANCH CODE");
		String monthfr = request.getParameter("MONTH FROM");
		String monthto = request.getParameter("MONTH TO");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
		   CallableStatement cs = con.prepareCall("{call OLL.PR_SALARY_REGISTER(?,?,?,?,?,?)}");
			cs.setString(1, "PR_SALARY_REGISTER");
			cs.setString(2, compcode);
			cs.setString(3, emptype);
			cs.setString(4, bcode);
			cs.setString(5, monthfr);
			cs.setString(6, monthto);
			/*  For Viewing Output  */
			System.out.println(compcode);
			System.out.println(emptype);
			System.out.println(bcode);
			System.out.println(monthfr);
			System.out.println(monthto);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/PR_SALARY_REGISTER.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}

