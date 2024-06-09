package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.ConsumerDTO;

public class ConsumerDAO {
    // JDBC 연결 정보
    private final String JDBC_URL = "jdbc:mysql://localhost:3306/ReservEatDB";
    private final String DB_USER = "your_database_username";
    private final String DB_PASSWORD = "your_database_password";

    // 소비자 정보를 DB에 추가하는 메서드
    public boolean addConsumer(ConsumerDTO consumer) {
        try (
            // JDBC 드라이버 로드
            Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            // SQL 쿼리 준비
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO consumers (consumerId, name, password, phonenumber, email) VALUES (?, ?, ?, ?, ?)"
            )
        ) {
            // SQL 쿼리에 값 채우기
            pstmt.setString(1, consumer.getConsumerId());
            pstmt.setString(2, consumer.getName());
            pstmt.setString(3, consumer.getPassword());
            pstmt.setString(4, consumer.getPhonenumber());
            pstmt.setString(5, consumer.getEmail());
            
            // SQL 쿼리 실행
            int rowsAffected = pstmt.executeUpdate();
            
            // 삽입이 성공적으로 이루어졌는지 확인
            return rowsAffected > 0;
        } catch (SQLException e) {
            // SQL 예외 처리
            e.printStackTrace();
            return false; // 소비자 추가 실패
        }
    }

    // 소비자 정보를 consumerId로 조회하는 메서드
    public ConsumerDTO getConsumerById(String consumerId) {
        try (
            // JDBC 드라이버 로드
            Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            // SQL 쿼리 준비
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT * FROM consumers WHERE consumerId = ?"
            )
        ) {
            // SQL 쿼리에 값 채우기
            pstmt.setString(1, consumerId);
            
            // SQL 쿼리 실행하여 결과 집합 받기
            try (ResultSet rs = pstmt.executeQuery()) {
                // 결과 집합이 있는지 확인
                if (rs.next()) {
                    // 결과 집합에서 소비자 정보 추출하여 ConsumerDTO 객체 생성하여 반환
                    ConsumerDTO consumer = new ConsumerDTO();
                    consumer.setConsumerId(rs.getString("consumerId"));
                    consumer.setName(rs.getString("name"));
                    consumer.setPassword(rs.getString("password"));
                    consumer.setPhonenumber(rs.getString("phonenumber"));
                    consumer.setEmail(rs.getString("email"));
                    return consumer;
                } else {
                    return null; // 해당 consumerId에 해당하는 소비자 없음
                }
            }
        } catch (SQLException e) {
            // SQL 예외 처리
            e.printStackTrace();
            return null; // 소비자 조회 실패
        }
    }
}
