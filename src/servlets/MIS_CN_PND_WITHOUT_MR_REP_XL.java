package servlets;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/MIS_CN_PND_WITHOUT_MR_REP_XL")
public class MIS_CN_PND_WITHOUT_MR_REP_XL extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*  InPut Parameter  */
		String bcode = request.getParameter("BRANCH CODE");
		String compcode = request.getParameter("COMPANY CODE");
		String frdt=request.getParameter("FROM DATE");
		String todt=request.getParameter("TO DATE");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
		   CallableStatement cs = con.prepareCall("{call OLL.MIS_CN_PND_WITHOUT_MR_REP_XL(?,?,?,?,?)}");
			cs.setString(1, "CN_PND_WITHOUT_MR");
			cs.setString(2, bcode);
			cs.setString(3, compcode);
			cs.setDate(4, java.sql.Date.valueOf(frdt));
			cs.setDate(5,java.sql.Date.valueOf(todt));
			/*  For Viewing Output  */
			System.out.println(bcode);
			System.out.println(compcode);
			System.out.println(frdt);
			System.out.println(todt);
			
			ResultSet rs=cs.executeQuery();
			
			HttpSession session = request.getSession(false);
			session.setAttribute("resulset", rs);
			response.sendRedirect("http://203.89.134.102/oracle/mis/CN_PND_WITHOUT_MR.CSV");
			//response.sendRedirect("downloadReport.jsp");
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());
			
		} 

	}

}

