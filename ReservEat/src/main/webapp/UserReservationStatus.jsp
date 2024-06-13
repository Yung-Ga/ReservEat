<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.net.URLEncoder" %>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>내 예약 현황</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding-top: 20px;
        }
    </style>
</head>
<body>
<%
    String userID = (String) session.getAttribute("userID");

    // 세션 값 출력 (디버깅용)
    System.out.println("UserReservationStatus: UserID = " + userID);

    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> reservations = new ArrayList<>();

    try {
        String sql = "SELECT r.ReservationID, r.ReservationDate, r.ReservationTime, r.NumberOfPeople, r.ReservationStatus, s.StoreName, r.StoreID " +
                     "FROM Reservation r " +
                     "JOIN Store s ON r.StoreID = s.StoreID " +
                     "WHERE r.UserID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> reservation = new HashMap<>();
            reservation.put("ReservationID", rs.getInt("ReservationID"));
            reservation.put("ReservationDate", rs.getDate("ReservationDate"));
            reservation.put("ReservationTime", rs.getTime("ReservationTime"));
            reservation.put("NumberOfPeople", rs.getInt("NumberOfPeople"));
            reservation.put("ReservationStatus", rs.getString("ReservationStatus"));
            reservation.put("StoreName", rs.getString("StoreName"));
            reservation.put("StoreID", rs.getInt("StoreID")); // StoreID 추가
            reservations.add(reservation);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<div class="container">
    <%@ include file="menu.jsp" %>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">내 예약 현황</h1>
            <p class="col-md-8 fs-4">사용자 <%= (String) session.getAttribute("userName") %>님의 예약 내역입니다.</p>
        </div>
    </div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>예약 ID</th>
                <th>가게 이름</th>
                <th>예약 날짜</th>
                <th>예약 시간</th>
                <th>인원수</th>
                <th>예약 상태</th>
                <th>리뷰 작성</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (reservations.isEmpty()) {
            %>
                <tr>
                    <td colspan="7" class="text-center">예약한 음식점이 없습니다.</td>
                </tr>
            <%
                } else {
                    for (Map<String, Object> reservation : reservations) {
                        String encodedStoreName = URLEncoder.encode((String) reservation.get("StoreName"), "UTF-8");
            %>
                <tr>
                    <td><%= reservation.get("ReservationID") %></td>
                    <td><%= reservation.get("StoreName") %></td>
                    <td><%= reservation.get("ReservationDate") %></td>
                    <td><%= reservation.get("ReservationTime") %></td>
                    <td><%= reservation.get("NumberOfPeople") %></td>
                    <td><%= reservation.get("ReservationStatus") %></td>
                    <td>
                        <%
                            if ("Completion".equals(reservation.get("ReservationStatus"))) {
                        %>
                            <a href="writeReview.jsp?reservationID=<%= reservation.get("ReservationID") %>&storeID=<%= reservation.get("StoreID") %>&storeName=<%= encodedStoreName %>" class="btn btn-primary btn-sm">리뷰 쓰기</a>
                        <%
                            } else {
                                out.print("-");
                            }
                        %>
                    </td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
