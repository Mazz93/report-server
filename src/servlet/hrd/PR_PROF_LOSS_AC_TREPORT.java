package servlet.hrd;


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

@WebServlet("/PR_PROF_LOSS_AC_TREPORT")
public class PR_PROF_LOSS_AC_TREPORT extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*  InPut Parameter  */
    	 String pcode = request.getParameter("PARTY_CODE");
         String frdt = request.getParameter("FROM_DATE");
         String todt = request.getParameter("TO_DATE");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
          //   Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
           CallableStatement cs = con.prepareCall("{call OLL.PR_PROF_LOSS_AC_TREPORT(?,?,?,?)}");
            cs.setString(1, "PR_PROF_LOSS_AC_TREPORT");
            cs.setString(2, pcode);
            cs.setDate(3, java.sql.Date.valueOf(frdt));
            cs.setDate(4, java.sql.Date.valueOf(todt));
            /*  For Viewing Output  */
            System.out.println(pcode);
            System.out.println(frdt);
            System.out.println(todt);

            ResultSet rs=cs.executeQuery();

            HttpSession session = request.getSession(false);
            session.setAttribute("resulset", rs);
response.sendRedirect("http://203.89.134.102/oracle/mis/PR_PROF_LOSS_AC_TREPORT.CSV");
            //response.sendRedirect("downloadReport.jsp");
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());

        }

    }

}
