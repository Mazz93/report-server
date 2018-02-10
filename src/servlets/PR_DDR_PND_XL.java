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

@WebServlet("/PR_DDR_PND_XL")
public class PR_DDR_PND_XL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String compcode = request.getParameter("COMPANY CODE");
		String bcode = request.getParameter("BRANCH CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
		   CallableStatement cs = con.prepareCall("{call OLL.PR_DDR_PND_XL(?,?,?,?,?)}");
			cs.setString(1, "PR_DDR_PND");
			cs.setString(2, compcode);
			cs.setString(3, bcode);
			cs.setString(4, frdt);
			cs.setString(5, todt);
			/*  For Viewing Output  */
			System.out.println(compcode);			
			System.out.println(bcode);
			System.out.println(frdt);
			System.out.println(todt);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/PR_DDR_PND.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}

