<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    String reservationID = request.getParameter("reservationID");

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE Reservation SET Status = 'Cancelled' WHERE ReservationID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(reservationID));
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
