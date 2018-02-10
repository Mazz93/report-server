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


@WebServlet("/MIS_CN_BILL_PND_REP")
public class MIS_CN_BILL_PND_REP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String compcode = request.getParameter("COMPANY CODE");
		String bookingbr = request.getParameter("BOOKING BRANCH");
		String date = request.getParameter("AS ON DATE");
		String cnr = request.getParameter("CONSIGNOR");
		String cne = request.getParameter("CONSIGNEE");
		String party = request.getParameter("PARTY");
		String reportype = request.getParameter("REPORT TYPE");
		String cnrname = request.getParameter("CONSIGNORE NAME");
		String  cnename= request.getParameter("CONSIGNEE NAME");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			CallableStatement cs = con.prepareCall("{call OLL.MIS_CN_BILL_PND_REP(?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "CN_BILL_PND");
		    cs.setString(2, compcode);
			cs.setString(3, bookingbr);
			cs.setDate(4, java.sql.Date.valueOf(date));
			cs.setString(5, cnr);
			cs.setString(6, cne);
			cs.setString(7, party);
			cs.setString(8, reportype);
			cs.setString(9, cnrname);
			cs.setString(10, cnrname);
			/*  For Viewing Output  */
			System.out.println(compcode);
			System.out.println(bookingbr);
			System.out.println(date);
			System.out.println(cnr);
			System.out.println(cne);
			System.out.println(party); 
			System.out.println(reportype);
			System.out.println(cnrname);
			System.out.println(cnrname);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/CN_BILL_PND.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
