<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>예약 목록</title>
</head>
<body>
<div class="container py-4">
    <h1 class="display-5 fw-bold">예약 목록</h1>
    <%@ include file="dbconn.jsp" %>
    <table class="table">
        <thead>
            <tr>
                <th>예약 ID</th>
                <th>음식점</th>
                <th>날짜</th>
                <th>시간</th>
                <th>인원</th>
                <th>상태</th>
                <th>취소</th>
            </tr>
        </thead>
        <tbody>
        <%
            String userID = "1"; // 예제에서는 고정된 사용자 ID 사용, 실제 구현에서는 세션이나 로그인 정보에서 가져옴
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                String sql = "SELECT r.ReservationID, s.StoreName, r.ReservationDate, r.ReservationTime, r.NumberOfPeople, r.Status FROM Reservation r JOIN Store s ON r.StoreID = s.StoreID WHERE r.UserID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(userID));
                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("ReservationID") %></td>
                <td><%= rs.getString("StoreName") %></td>
                <td><%= rs.getDate("ReservationDate") %></td>
                <td><%= rs.getTime("ReservationTime") %></td>
                <td><%= rs.getInt("NumberOfPeople") %></td>
                <td><%= rs.getString("Status") %></td>
                <td>
                    <form method="post" action="cancelReservation.jsp">
                        <input type="hidden" name="reservationID" value="<%= rs.getInt("ReservationID") %>" />
                        <button type="submit" class="btn btn-danger btn-sm">취소</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
