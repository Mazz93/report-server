package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ConnectionDAO dao = new ConnectionDAO();
		Statement statement = null;
		try {

			statement = dao.getConnection();
			String empcode = request.getParameter("empcode");
			String password = request.getParameter("password");

			ResultSet resultset = statement
					.executeQuery("SELECT distinct USER_USER_ID,USER_PASS_WORD FROM OLL.COR_USER_M WHERE USER_USER_ID='"
							+ empcode + "' and USER_PASS_WORD= '" + password + "'");

			HttpSession session = request.getSession(false);
			if (resultset.next()) {
				Statement statement1 = dao.getConnection();

				ResultSet resultset1 = statement1.executeQuery(
						"SELECT DISTINCT DEPT,BRANCH,user_level FROM OLL.COR_USER_PERMISSION where USER_ID='" + empcode + "'");

				String user_level="";
				if (resultset1.next()) {
					String branch = resultset1.getString(2);
					System.out.println(branch);
					String dept = resultset1.getString(1);
					System.out.println(dept);
					
					user_level = resultset1.getString(3);
					System.out.println(user_level);
					session.setAttribute("user_id", empcode);
					session.setAttribute("branch", branch);
					session.setAttribute("dept", dept);
					session.setAttribute("loginSession", "true");
					response.sendRedirect("dashboard.jsp");
					/*//user level 99 super admin
					if(user_level.equals("99")) {
						response.sendRedirect("dashboard");
					}
					//user level 98 admin
					else if(user_level.equals("98")) {
						response.sendRedirect("dashboard.jsp");
					}else{
						//user
						response.sendRedirect("dashboard.jsp");
					}*/
				}
				
			} else {
				session.setAttribute("log_error", "invalid username or password");
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.closeConnection();
			try {
				statement.close();
				System.out.println("statement2 closed");
			} catch (Exception e2) {
				System.out.println(e2);
			}

		}
	}

}
