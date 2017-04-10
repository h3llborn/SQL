package exercises;
/*
 * 
 * Purpose: Project 2 Prep
 * Author: Chris Niesel
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;

public class Project2 {
	
	static Connection conn = null;
	static Statement stmt = null;
	static String dbURL	   = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static String user	   = "projects";
	static String password = "projects";
	static BufferedReader br = new BufferedReader (new InputStreamReader(System.in));
	static String customerID = "";
	
	// create new instance of this Class
	public Project2(){
		
	}

	public static void main(String[] args) throws SQLException,IOException {
		
		// register the driver with the class manager
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(ClassNotFoundException e){
			System.err.println(e.getMessage());
		}
		
		
		// open and close the connection
		try{
			conn = DriverManager.getConnection(dbURL,user, password	);
			conn.clearWarnings();
			System.out.println("Connection established! for driver ==> Oracle 11XE");
			stmt = conn.createStatement();
			ResultSet rs;
			ResultSetMetaData meta;
			
			while(!customerID.equalsIgnoreCase("X")){
				
				System.out.print("Please Enter CustomerID:");
				customerID = br.readLine();
				System.out.println("");
				rs = stmt.executeQuery("SELECT CompanyName, TO_Char((Select sysdate from dual),'DD/MM/YYYY') AS \"Date\" FROM Customers WHERE customerID = '"+ customerID+"'");
				while(rs.next()){
					System.out.println("Statistics for " + rs.getString(1) + " " + rs.getString(2) + " By Christopher Niesel\n");
				}
				
				rs = stmt.executeQuery("SELECT RPAD(ORDERID,8) as ORDERID, TO_CHAR(ORDERDate,'DD/MM/YYYY')AS \"Order Date\", RPAD(nvl2(ShippedDate,'Shipped','Not Shipped'),12) as \"Order Status\",TO_Char((SELECT sum((unitprice -(unitprice * discount))*quantity) FROM ORDERDETAILS WHERE orderdetails.orderid = ORDERS.ORDERID),'$9,999.99') as \"ORDER TOTAL\" from ORDERS WHERE CUSTOMERID = '"+ customerID+"' ORDER BY 4 DESC");
				meta = rs.getMetaData();
				System.out.println(meta.getColumnName(1) + "\t\t" + meta.getColumnName(2) + "\t" + meta.getColumnName(3) + "\t" + meta.getColumnName(4));
				while(rs.next()){
					System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3)+ "\t" + rs.getString(4));
				}
				System.out.print("\n");
				rs.close();
			}
			
		
		} catch (SQLException e){
			System.err.println(e.getMessage());
		}finally{
			if(!conn.isClosed()){
				conn.close();
				System.out.println("Connection closed! Oracle");
			}
		}
		
	}

}
