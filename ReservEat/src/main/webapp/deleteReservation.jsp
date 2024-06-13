<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    int reservationID = Integer.parseInt(request.getParameter("ReservationID"));
    PreparedStatement pstmt = null;

    try {
        String deleteSql = "DELETE FROM Reservation WHERE ReservationID = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, reservationID);
        int deletedRows = pstmt.executeUpdate();
        System.out.println("Debug: Deleted rows = " + deletedRows);
        
        // 세션에 메시지 설정
        session.setAttribute("message", "Reservation has been successfully deleted.");
        
        // viewReservations.jsp로 리디렉션
        response.sendRedirect("viewReservations.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        session.setAttribute("message", "Error occurred while deleting the reservation: " + e.getMessage());
        response.sendRedirect("viewReservations.jsp");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
