package servlets.ops;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

@WebServlet("/PR_BOOKING_REPORT1")
public class PR_BOOKING_REPORT1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String brcode = request.getParameter("BRANCH CODE");
		String frdt = request.getParameter("FROM DATE");
		String todt = request.getParameter("TO DATE");
		String cnr = request.getParameter("CONSIGNOR CODE");
		String cne = request.getParameter("CONSIGNEE CODE");
		String partycode = request.getParameter("PARTY CODE");
		String disctcode = request.getParameter("DIST CODE");
		String tmode = request.getParameter("TRANSPORT MODE");
		String frmode = request.getParameter("FREIGHT MODE");
		String compcode = request.getParameter("COMPANY CODE");
		
		if(brcode.equals("*")){ brcode="9999"; }else {brcode=brcode;}
		if(cnr.equals("*")){ cnr="999999"; }else {cnr=cnr;}
		if(cne.equals("*")){ cne="999999"; }else {cne=cne;}
		if(partycode.equals("*")){ partycode="999999"; }else {partycode=partycode;}
		if(disctcode.equals("*")){ disctcode="9999"; }else {disctcode=disctcode;}
		if(tmode.equals("*")){ tmode="9"; }else {tmode=tmode;}
		if(frmode.equals("*")){ frmode="9"; }else {frmode=frmode;}
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			 Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			// Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
		   CallableStatement cs = con.prepareCall("{call OLL.PR_BOOKING_REPORT1(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "Pr_Booking_Rep");
		    cs.setString(2, brcode);
			cs.setDate(3, java.sql.Date.valueOf(frdt));
			cs.setDate(4, java.sql.Date.valueOf(todt));
			cs.setString(5, cnr);
			cs.setString(6, cne);
			cs.setString(7, partycode);
			cs.setString(8, disctcode);
			cs.setString(9, tmode);
			cs.setString(10, frmode);
			cs.setString(11, compcode);
			/*  For Viewing Output */
			System.out.println(compcode);
			System.out.println(brcode);
			System.out.println(frdt);
			System.out.println(todt);
			System.out.println(cnr);
			System.out.println(cne);
			System.out.println(partycode); 
			System.out.println(disctcode);
			System.out.println(tmode);
			System.out.println(frmode); 
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/Pr_Booking_Rep.CSV");
			//response.sendRedirect("http://203.89.134.50/oracle/mis/Pr_Booking_Rep.CSV");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}
