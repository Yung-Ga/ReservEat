<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp"%>
<%
    // 세션에서 storeID를 가져옵니다
    if (session == null || session.getAttribute("storeID") == null) {
        response.sendRedirect("storeLogInPage.jsp"); // 로그인 페이지로 리디렉션
        return;
    }
    int storeID = Integer.parseInt(session.getAttribute("storeID").toString());

    // 지난 시간대를 삭제합니다
    PreparedStatement pstmt = null;
    try {
        String deleteSql = "DELETE FROM Reservation WHERE StoreID = ? AND UserID IS NULL AND (ReservationDate < CURDATE() OR (ReservationDate = CURDATE() AND ReservationTime < CURTIME()))";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, storeID);
        int deletedRows = pstmt.executeUpdate();
        System.out.println("Debug: Deleted rows = " + deletedRows);
        
        // 세션에 메시지 설정
        session.setAttribute("message", "Old reservations have been successfully reset.");
        
        // viewReservations.jsp로 리디렉션
        response.sendRedirect("viewReservations.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        session.setAttribute("message", "Error occurred while resetting reservations: " + e.getMessage());
        response.sendRedirect("viewReservations.jsp");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
