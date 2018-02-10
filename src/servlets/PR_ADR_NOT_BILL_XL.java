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


@WebServlet("/PR_ADR_NOT_BILL_XL")
public class PR_ADR_NOT_BILL_XL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String brcode = request.getParameter("BRANCH CODE");
		String pcode = request.getParameter("PARTY CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		String distname = request.getParameter("DIST NAME");
		String cnr = request.getParameter("CONSIGNOR");
		String cne = request.getParameter("CONSIGNEE");
		String tmode = request.getParameter("T MODE");
		String frtmode = request.getParameter("FREIGHT MODE");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			CallableStatement cs = con.prepareCall("{call OLL.PR_ADR_NOT_BILL_XL(?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "ADR_NOT_BILL");
		    cs.setString(2, brcode);
			cs.setString(3, pcode);
			cs.setString(4, frdt);
			cs.setString(5, todt);
			cs.setString(6, distname);
			cs.setString(7, cnr);
			cs.setString(8, cne);
			cs.setString(9, tmode);
			cs.setString(10, frtmode);
			/*  For Viewing Output  */
			System.out.println(brcode);
			System.out.println(pcode);
			System.out.println(frdt);
			System.out.println(todt);
			System.out.println(distname);
			System.out.println(cnr); 
			System.out.println(cne);
			System.out.println(tmode);
			System.out.println(frtmode);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/ADR_NOT_BILL.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
 