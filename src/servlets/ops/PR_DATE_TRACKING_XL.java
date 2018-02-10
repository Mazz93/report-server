package servlets.ops;

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


@WebServlet("/PR_DATE_TRACKING_XL")
public class PR_DATE_TRACKING_XL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String compcode = request.getParameter("COMPANY CODE");
		String bcode = request.getParameter("BRANCH CODE");
		String pcode = request.getParameter("PARTY CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			CallableStatement cs = con.prepareCall("{call OLL.PR_DATE_TRACKING_XL(?,?,?,?,?,?)}");
			cs.setString(1, "PR_DATE_TRACKING");
			cs.setString(2, compcode);
			cs.setString(3, bcode);
			cs.setString(4, pcode);
			cs.setDate(5, java.sql.Date.valueOf(frdt));
			cs.setDate(6, java.sql.Date.valueOf(todt));
			
			/*  For Viewing Output  */
			System.out.println(compcode);
			System.out.println(bcode);
			System.out.println(pcode);
			System.out.println(frdt);
			System.out.println(todt);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/PR_DATE_TRACKING.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
