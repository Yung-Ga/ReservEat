<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    String userID = "yung_ga"; // 예제에서는 고정된 사용자 ID 사용, 실제 구현에서는 세션이나 로그인 정보에서 가져옴
    String storeID = request.getParameter("storeID");
    String reservationDate = request.getParameter("reservationDate");
    String reservationTime = request.getParameter("reservationTime");
    int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));

    PreparedStatement pstmt = null;

    try {
        String sql = "INSERT INTO Reservation (UserID, StoreID, ReservationDate, ReservationTime, NumberOfPeople, Status) VALUES (?, ?, ?, ?, ?, 'Confirmed')";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setInt(2, Integer.parseInt(storeID));
        pstmt.setDate(3, java.sql.Date.valueOf(reservationDate));
        pstmt.setTime(4, java.sql.Time.valueOf(reservationTime + ":00"));
        pstmt.setInt(5, numberOfPeople);
        pstmt.executeUpdate();
        response.sendRedirect("viewReservations.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
