package exercises;
/*
 * 
 * Purpose: connect to database using Oracle thin driver
 * Author: Chris Niesel
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;

public class Lab10 {
	
	static Connection conn = null;
	static Statement stmt = null;
	static String dbURL	   = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static String user	   = "projects";
	static String password = "projects";
	static BufferedReader br = new BufferedReader (new InputStreamReader(System.in));
	static String option = "";
	
	// create new instance of this Class
	public Lab10(){
		
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
			
			while(!option.equalsIgnoreCase("X")){
				
				System.out.print("Want to do Q1 (1) or Q2 (2) or (X) exit: ");
				option = br.readLine();
				System.out.println("");
				if(option.equalsIgnoreCase("1")){
					rs = stmt.executeQuery("SELECT * FROM VQ1");
					System.out.println("Lab 10 - Christopher Niesel");
					System.out.println("  ID\t\t Product\t\t\t Price");
					System.out.println("======\t\t=========\t\t\t=======");
					while(rs.next()){
						System.out.println(rs.getString("Product ID") + "\t" + rs.getString("Product Name") + "\t" + rs.getString("Unit Price"));
					}
					rs.close();
				}
				if(option.equalsIgnoreCase("2")){
					rs = stmt.executeQuery("SELECT * FROM VQ2");
					System.out.println("Order\tOrder Date\tShip Date\tCompany");
					System.out.println("=====\t==========\t========\t=======");
					while(rs.next()){
						System.out.println(rs.getString("Order") + "" + rs.getString("Order Date") + "    " + rs.getString("Ship Date") +
								"\t" + rs.getString("Company"));
					}
					rs.close();
				}
				
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
