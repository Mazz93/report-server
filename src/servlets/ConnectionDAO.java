package servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class ConnectionDAO {
	Connection con;
	Statement statement;
	public Statement getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.50:1521:orcltest", "oll", "zebronics");
			  con = DriverManager.getConnection("jdbc:oracle:thin:@203.89.134.102:1521:ollbd12c", "juser", "Java8102India");
			
			statement = con.createStatement();
		} catch (Exception e) {
			System.out.println(e);
		}
		return statement;
	}
	public void closeConnection() {
		try {
			con.close();
			System.out.println("connection closed");
			statement.close();
			System.out.println("statement closed");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
