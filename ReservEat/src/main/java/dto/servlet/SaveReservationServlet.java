package dto.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveReservationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object storeIDObj = request.getSession().getAttribute("storeID");
        if (storeIDObj == null) {
            response.sendRedirect("storeLogInPage.jsp"); // 로그인 페이지로 리디렉션
            return;
        }
        
        int storeID = Integer.parseInt(storeIDObj.toString());
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // DB 연결
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ReservEatDB", "root", "0806");

            // 가게의 영업 시간을 가져옵니다
            String openTime = null;
            String closeTime = null;
            String sql = "SELECT OpenTime, CloseTime FROM Store WHERE StoreID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, storeID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                openTime = rs.getString("OpenTime");
                closeTime = rs.getString("CloseTime");
            }

            pstmt.close();
            rs.close();

            // 지난 시간대를 삭제합니다 (UserID가 NULL인 경우)
            String deleteSql = "DELETE FROM Reservation WHERE StoreID = ? AND UserID IS NULL AND (ReservationDate < CURDATE() OR (ReservationDate = CURDATE() AND ReservationTime < CURTIME()))";
            PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
            deletePstmt.setInt(1, storeID);
            deletePstmt.executeUpdate();
            deletePstmt.close();

            // 예약 가능한 시간대를 1주일 단위로 생성하여 DB에 저장
            sql = "INSERT INTO Reservation (StoreID, ReservationDate, ReservationTime, ReservationStatus, NumberOfPeople) VALUES (?, ?, ?, 'Pending', 0)";
            pstmt = conn.prepareStatement(sql);

            Calendar calendar = Calendar.getInstance();
            Calendar startTimeCalendar = Calendar.getInstance();
            startTimeCalendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(openTime.split(":")[0]));
            startTimeCalendar.set(Calendar.MINUTE, Integer.parseInt(openTime.split(":")[1]));
            startTimeCalendar.set(Calendar.SECOND, Integer.parseInt(openTime.split(":")[2]));

            Calendar endTimeCalendar = Calendar.getInstance();
            endTimeCalendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(closeTime.split(":")[0]));
            endTimeCalendar.set(Calendar.MINUTE, Integer.parseInt(closeTime.split(":")[1]));
            endTimeCalendar.set(Calendar.SECOND, Integer.parseInt(closeTime.split(":")[2]));

            Calendar now = Calendar.getInstance(); // 현재 시간

            for (int day = 0; day < 7; day++) { // 1주일 단위
                Calendar dayCalendar = (Calendar) calendar.clone();
                dayCalendar.add(Calendar.DAY_OF_MONTH, day);

                for (Calendar timeCalendar = (Calendar) startTimeCalendar.clone(); 
                        timeCalendar.before(endTimeCalendar); 
                        timeCalendar.add(Calendar.HOUR_OF_DAY, 1)) {

                    if (day == 0 && timeCalendar.before(now)) {
                        // 현재 날짜의 지난 시간은 건너뜀
                        continue;
                    }

                    java.sql.Date currentDate = new java.sql.Date(dayCalendar.getTimeInMillis());
                    java.sql.Time currentTime = new java.sql.Time(timeCalendar.getTimeInMillis());

                    // 중복 체크
                    String checkSQL = "SELECT COUNT(*) FROM Reservation WHERE StoreID = ? AND ReservationDate = ? AND ReservationTime = ?";
                    PreparedStatement checkPstmt = conn.prepareStatement(checkSQL);
                    checkPstmt.setInt(1, storeID);
                    checkPstmt.setDate(2, currentDate);
                    checkPstmt.setTime(3, currentTime);
                    ResultSet checkRs = checkPstmt.executeQuery();

                    if (checkRs.next() && checkRs.getInt(1) == 0) { // 중복되지 않은 경우에만 삽입
                        pstmt.setInt(1, storeID);
                        pstmt.setDate(2, currentDate);
                        pstmt.setTime(3, currentTime);
                        pstmt.addBatch();
                    }

                    checkRs.close();
                    checkPstmt.close();
                }
            }

            pstmt.executeBatch();
            pstmt.close();

            request.getSession().setAttribute("message", "Reservation availability saved successfully for the next week.");
            response.sendRedirect("viewReservations.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
