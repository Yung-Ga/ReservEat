package dto.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void destroy() {
        super.destroy();
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginType = request.getParameter("loginType");
        String identifier = request.getParameter("identifier");
        String password = request.getParameter("password");

        System.out.println("Debug: Received loginType=" + loginType + ", identifier=" + identifier + ", password=" + password);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Debug: MySQL JDBC Driver Registered!");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Error: MySQL JDBC Driver not found.");
            response.sendRedirect("login.jsp?error=true&message=driverNotFound");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ReservEatDB", "root", "0806")) {
            System.out.println("Debug: Database connection established.");

            String sql;
            if ("store".equals(loginType)) {
                sql = "SELECT * FROM Store WHERE RegistrationNumber = ? AND Password = ?";
            } else if ("user".equals(loginType)) {
                sql = "SELECT * FROM User WHERE UserID = ? AND Password = ?";
            } else {
                response.sendRedirect("login.jsp?error=true&message=invalidLoginType");
                return;
            }

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, identifier);
                pstmt.setString(2, password);

                System.out.println("Debug: Executing query: " + pstmt);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        if ("store".equals(loginType)) {
                            int storeID = rs.getInt("StoreID");
                            String storeName = rs.getString("StoreName");

                            System.out.println("Debug: Store found: StoreID=" + storeID + ", StoreName=" + storeName);
                            
                            session.setAttribute("storeID", storeID);
                            session.setAttribute("storeName", storeName);

                            response.sendRedirect("businessPage.jsp");
                        } else if ("user".equals(loginType)) {
                            String userID = rs.getString("UserID");
                            String userName = rs.getString("UserName");
                            String email = rs.getString("Email");
                            String phoneNumber = rs.getString("PhoneNumber");
                            String address = rs.getString("Address");
                            String gender = rs.getString("Gender");
                            String birthYY = rs.getString("BirthYY");
                            String birthMM = rs.getString("BirthMM");
                            String birthDD = rs.getString("BirthDD");

                            System.out.println("Debug: User found: UserID=" + userID + ", UserName=" + userName);
                            
                            session.setAttribute("userID", userID);
                            session.setAttribute("userName", userName);
                            session.setAttribute("email", email);
                            session.setAttribute("phoneNumber", phoneNumber);
                            session.setAttribute("address", address);
                            session.setAttribute("gender", gender);
                            session.setAttribute("birthYY", birthYY);
                            session.setAttribute("birthMM", birthMM);
                            session.setAttribute("birthDD", birthDD);

                            response.sendRedirect("mypage.jsp");
                        }
                    } else {
                        System.out.println("Debug: 로그인 실패: 일치하는 사용자 없음");
                        response.sendRedirect("StartPage.jsp?error=true&message=noUser");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error: SQLException occurred during query execution.");
                response.sendRedirect("StartPage.jsp?error=true&message=sqlError&details=" + e.getMessage());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error: SQLException occurred during connection.");
            response.sendRedirect("StartPage.jsp?error=true&message=connectionError&details=" + e.getMessage());
        }
    }
}
