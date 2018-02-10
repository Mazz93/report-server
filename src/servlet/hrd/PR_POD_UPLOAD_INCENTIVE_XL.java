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


@WebServlet("/PR_POD_UPLOAD_INCENTIVE_XL")
public class PR_POD_UPLOAD_INCENTIVE_XL extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*  InPut Parameter  */

        String MMYYYY = request.getParameter("MM-YYYY");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
            // Connection con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "oll");
           CallableStatement cs = con.prepareCall("{call OLL.PR_POD_UPLOAD_INCENTIVE_XL(?,?)}");
            cs.setString(1, "PR_POD_UPLOAD_INCENTIVE_XL");
            cs.setString(2, MMYYYY);

            /*  For Viewing Output  */
            System.out.println(MMYYYY);


            ResultSet rs=cs.executeQuery();

            HttpSession session = request.getSession(false);
            session.setAttribute("resulset", rs);
response.sendRedirect("http://203.89.134.102/oracle/mis/PR_POD_UPLOAD_INCENTIVE_XL.CSV");
            //response.sendRedirect("downloadReport.jsp");
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("err_Message", "PROCEDURE Error:" + "<br>" +   e.getMessage());

        }

    }

} 