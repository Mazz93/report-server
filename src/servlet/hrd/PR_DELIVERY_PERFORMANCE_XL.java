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


@WebServlet("/PR_DELIVERY_PERFORMANCE_XL")
public class PR_DELIVERY_PERFORMANCE_XL extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*  InPut Parameter  */
        String bcode = request.getParameter("BRANCH_CODE");
        String frdt = request.getParameter("FROM_DATE");
        String todt = request.getParameter("TO_DATE");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
            // Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
           CallableStatement cs = con.prepareCall("{call OLL.PR_DELIVERY_PERFORMANCE_XL(?,?,?,?)}");
            cs.setString(1, "PR_DELIVERY_PERFORMANCE");
            cs.setString(2, bcode);
            cs.setDate(3, java.sql.Date.valueOf(frdt));
            cs.setDate(4, java.sql.Date.valueOf(todt));
            /*  For Viewing Output  */
            System.out.println(bcode);
            System.out.println(frdt);
            System.out.println(todt);

            ResultSet rs=cs.executeQuery();

            HttpSession session = request.getSession(false);
            session.setAttribute("resulset", rs);
response.sendRedirect("http://203.89.134.102/oracle/mis/PR_DELIVERY_PERFORMANCE.CSV");
            //response.sendRedirect("downloadReport.jsp");
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());

        }

    }

} 