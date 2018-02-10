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


@WebServlet("/MIS_CN_DLVRY_NOT_BILL_REP")
public class MIS_CN_DLVRY_NOT_BILL_REP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String bcode = request.getParameter("BRANCH CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			CallableStatement cs = con.prepareCall("{call OLL.MIS_CN_DLVRY_NOT_BILL_REP(?,?,?,?)}");
			cs.setString(1, "CN_DLVRY_NOT_BILL");
			cs.setString(2, bcode);
			cs.setString(3, frdt);
			cs.setString(4, todt);
			/*  For Viewing Output  */
			System.out.println(bcode);
			System.out.println(frdt);
			System.out.println(todt);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/CN_DLVRY_NOT_BILL.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}

   