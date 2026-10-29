package com.bus;
import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection{
    public static Connection getConnection() throws Exception{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/busdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            "root",
            "Chetan@13"
        );
        return con;
    }
}