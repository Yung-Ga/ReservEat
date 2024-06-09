package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.District;

public class DistrictDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/StoreCustomerDB?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "0806";

    public static List<District> getDistricts() {
        List<District> districts = new ArrayList<>();
        String sql = "SELECT DistrictID, DistrictName FROM District";
        
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                int districtID = rs.getInt("DistrictID");
                String districtName = rs.getString("DistrictName");
                districts.add(new District(districtID, districtName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return districts;
    }
}