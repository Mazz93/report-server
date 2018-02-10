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


@WebServlet("/PR_FPM_LESS_PAYMENT")
public class PR_FPM_LESS_PAYMENT extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			CallableStatement cs = con.prepareCall("{call OLL.PR_FPM_LESS_PAYMENT(?,?,?)}");
			cs.setString(1, "PR_FPM_LESS_PAYMENT");
		    cs.setString(2, frdt);
			cs.setString(3, todt);
			/*  For Viewing Output  */
			System.out.println(frdt);
			System.out.println(todt);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/PR_FPM_LESS_PAYMENT.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
