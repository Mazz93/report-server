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


@WebServlet("/DAILY_PICK_ARRIVAL_REP")
public class DAILY_PICK_ARRIVAL_REP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String compcode = request.getParameter("COMPANY CODE");
		String bcode = request.getParameter("BRANCH CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		String cnr = request.getParameter("CONSIGNOR");
		String cne = request.getParameter("CONSIGNEE");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
		   CallableStatement cs = con.prepareCall("{call OLL.DAILY_PICK_ARRIVAL_REP(?,?,?,?,?,?,?)}");
			cs.setString(1, "DAILY_PICK_ARRIVAL");
		    cs.setString(2, compcode);
			cs.setString(3, bcode);
			cs.setDate(4, java.sql.Date.valueOf(frdt));
			cs.setDate(5, java.sql.Date.valueOf(todt));
			cs.setString(6, cnr);
			cs.setString(7, cne);
			/*  For Viewing Output  */
			System.out.println(compcode);
			System.out.println(bcode);
			System.out.println(frdt);
			System.out.println(todt);
			System.out.println(cnr);
			System.out.println(cne);
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/DAILY_PICK_ARRIVAL.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
