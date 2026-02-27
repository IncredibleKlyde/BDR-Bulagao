package config;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class connectDB {
    
    private Connection connect;
    
    // Constructor to establish the connection
    public connectDB(){
        System.out.println(
    new java.io.File("barangay_document_request_system.db").getAbsolutePath()
);
        try {
            Class.forName("org.sqlite.JDBC");

            connect = DriverManager.getConnection(
                "jdbc:sqlite:barangay_document_request_system.db"
            );

            System.out.println("Database connected successfully!");

        } catch (SQLException ex) {
            System.err.println("Can't connect to the database: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }
    // Method to return the connection
    public Connection getConnection() {
        return connect;
    }

    // Function to insert data
    public int insertData(String sql) {
        int result = 0;
        try (PreparedStatement pst = connect.prepareStatement(sql)) {
            pst.executeUpdate();
            System.out.println("Inserted successfully!");
            result = 1;
        } catch (SQLException ex) {
            System.err.println("Insert error: " + ex.getMessage());
        }
        return result;
    }

    // Function to retrieve data
    public ResultSet getData(String sql) throws SQLException {
        Statement stmt = connect.createStatement();
        return stmt.executeQuery(sql);
    }

    // Method to close the connection
    public void closeConnection() {
        try {
            if (connect != null && !connect.isClosed()) {
                connect.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException ex) {
            System.err.println("Error closing connection: " + ex.getMessage());
        }
    }
    
    // --- Logs
    
    public void logAction (String username, String action, String details) {
        
        String sql = "INSERT INTO system_logs (username, action, details) VALUES ('" + username + "', '" + action + "', '" + details + "')";
        
        if(insertData(sql) == 0) {
            System.out.println("Failed to insert log entry.");
        } else {
            System.out.println("Log entry successfully created.");
        }
    }
}


