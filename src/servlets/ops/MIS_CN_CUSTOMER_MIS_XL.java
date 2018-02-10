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


@WebServlet("/MIS_CN_CUSTOMER_MIS_XL")
public class MIS_CN_CUSTOMER_MIS_XL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		String compcode = request.getParameter("COMPANY CODE");
		String brcode = request.getParameter("BRANCH CODE");
		String bparty = request.getParameter("BILLING PARTY");
		String cnr = request.getParameter("CONSIGNOR");
		String cne = request.getParameter("CONSIGNEE");
	//	String pname = request.getParameter("PARTY NAME");
	//	String cnrname = request.getParameter("CONSIGNOR NAME");
	//	String cnename = request.getParameter("CONSIGNEE NAME");
		String dist = request.getParameter("DIST");
		String tmode = request.getParameter("T MODE");
		String frmode = request.getParameter("FREIGHT MODE");
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
		    CallableStatement cs = con.prepareCall("{call OLL.MIS_CN_CUSTOMER_MIS_XL2(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "CN_CUSTOMER_MIS");		    
			cs.setDate(2, java.sql.Date.valueOf(frdt));
			cs.setDate(3, java.sql.Date.valueOf(todt));
			cs.setString(4, compcode);
			cs.setString(5, brcode);
			cs.setString(6, bparty);
			cs.setString(7, cnr);
			cs.setString(8, cne);
		//	cs.setString(9, pname);
		//	cs.setString(10, cnrname);
		//	cs.setString(11, cnename);
			cs.setString(9, dist);
			cs.setString(10, tmode);
			cs.setString(11, frmode);
			
			/*  For Viewing Output  */
			
			System.out.println(frdt);
			System.out.println(todt);
			System.out.println(compcode);
			System.out.println(brcode);
			System.out.println(bparty);
			System.out.println(cnr);
			System.out.println(cne);
		//	System.out.println(pname);
		//	System.out.println(cnename); 
		//	System.out.println(cnrname);
			System.out.println(dist);
			System.out.println(tmode);
			System.out.println(frmode);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			//response.sendRedirect("http://203.89.134.102/oracle/mis/Pr_Booking_Rep.CSV");
			 response.sendRedirect("http://203.89.134.102/oracle/mis/CN_CUSTOMER_MIS.CSV");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
