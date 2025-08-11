package com.example;

import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DatabaseTest {

    private Connection connection;
    private Statement statement;

    @BeforeClass
    public void setUp() throws Exception {
        String url = "jdbc:mysql://localhost:3306/shop"; // DB = shop
        String user = "root"; // your MySQL username
        String password = "Serzo0125"; // replace with your MySQL password

        connection = DriverManager.getConnection(url, user, password);
        statement = connection.createStatement();
    }

    @Test
    public void testOrderCount() throws Exception {
        String query = "SELECT COUNT(*) AS totalOrders FROM Orders";

        ResultSet rs = statement.executeQuery(query);
        rs.next();
        int count = rs.getInt("totalOrders");

        // Adjust expected count based on your DB
        Assert.assertEquals(count, 5, "Order count does not match!");
    }

    @AfterClass
    public void tearDown() throws Exception {
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
}

