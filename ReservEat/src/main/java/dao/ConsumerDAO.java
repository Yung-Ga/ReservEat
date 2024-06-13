package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dto.ConsumerDTO;

public class ConsumerDAO {
    private Connection conn;

    public ConsumerDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addConsumer(ConsumerDTO consumer) {
        String sql = "INSERT INTO User (UserID, Password, UserName, Gender, BirthYY, BirthMM, BirthDD, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, consumer.getUserID());
            pstmt.setString(2, consumer.getPassword());
            pstmt.setString(3, consumer.getUserName());
            pstmt.setString(4, consumer.getGender());
            pstmt.setInt(5, Integer.parseInt(consumer.getBirthYY()));
            pstmt.setInt(6, Integer.parseInt(consumer.getBirthMM()));
            pstmt.setInt(7, Integer.parseInt(consumer.getBirthDD()));
            pstmt.setString(8, consumer.getEmail());
            pstmt.setString(9, consumer.getPhoneNumber());
            pstmt.setString(10, consumer.getAddress());
            System.out.println("Executing Query: " + pstmt); // 디버깅 로그 추가
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public ConsumerDTO getConsumerById(String userID) {
        ConsumerDTO consumer = null;
        String sql = "SELECT * FROM User WHERE UserID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                consumer = new ConsumerDTO();
                consumer.setUserID(rs.getString("UserID"));
                consumer.setPassword(rs.getString("Password"));
                consumer.setUserName(rs.getString("UserName"));
                consumer.setGender(rs.getString("Gender"));
                consumer.setBirthYY(rs.getString("BirthYY"));
                consumer.setBirthMM(rs.getString("BirthMM"));
                consumer.setBirthDD(rs.getString("BirthDD"));
                consumer.setEmail(rs.getString("Email"));
                consumer.setPhoneNumber(rs.getString("PhoneNumber"));
                consumer.setAddress(rs.getString("Address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consumer;
    }
}

