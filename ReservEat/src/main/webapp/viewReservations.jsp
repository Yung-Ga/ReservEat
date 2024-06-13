<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }

    // 세션에서 storeID를 가져옵니다
    if (session == null || session.getAttribute("storeID") == null) {
        response.sendRedirect("storeLogInPage.jsp"); // 로그인 페이지로 리디렉션
        return;
    }
    int storeID = Integer.parseInt(session.getAttribute("storeID").toString());

    PreparedStatement pstmt = null; // pstmt 변수 선언

    // 디버그 로그 추가
    System.out.println("Debug: storeID = " + storeID);
%>

<script>
function filterReservations() {
    var filterDate = document.getElementById('filterDate').value;
    var tableBody = document.getElementById('reservationTableBody');
    var rows = tableBody.getElementsByTagName('tr');

    for (var i = 0; i < rows.length; i++) {
        var dateCell = rows[i].getElementsByTagName('td')[1];
        if (dateCell) {
            var rowDate = dateCell.textContent || dateCell.innerText;
            if (filterDate && rowDate !== filterDate) {
                rows[i].style.display = 'none';
            } else {
                rows[i].style.display = '';
            }
        }
    }
}
</script>

<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>View Reservations</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">View Reservations</h1>
            <p class="col-md-8 fs-4">Manage reservation availability for your store.</p>
        </div>
    </div>
    <div class="text-end mb-3">
        <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
        <a href="saveReservation" class="btn btn-sm btn-primary">Reset Reservation</a> <!-- 서블릿 호출 -->
    </div>
    
    <% String message = (String) session.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
        <% session.removeAttribute("message"); %>
    <% } %>
    
    <div class="row mb-3">
        <div class="col-md-3">
            <input type="date" id="filterDate" class="form-control" placeholder="Select Date">
        </div>
        <div class="col-md-3">
            <button class="btn btn-sm btn-primary" onclick="filterReservations()">Filter</button>
        </div>
    </div>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th><fmt:message key="ReservationDate" /></th>
                <th><fmt:message key="ReservationTime" /></th>
                <th><fmt:message key="NumberOfPeople" /></th>
                <th><fmt:message key="ReservationStatus" /></th>
                <th><fmt:message key="CustomerName" /></th>
                <th><fmt:message key="CustomerPhoneNumber" /></th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="reservationTableBody">
        <%
            ResultSet rs = null;
            try {
                String sql = "SELECT r.ReservationID, r.ReservationDate, r.ReservationTime, r.NumberOfPeople, r.ReservationStatus, u.UserName, u.PhoneNumber, r.UserID " +
                             "FROM Reservation r " +
                             "LEFT JOIN User u ON r.UserID = u.UserID " +
                             "WHERE r.StoreID = ?";
                pstmt = conn.prepareStatement(sql); // pstmt 초기화
                pstmt.setInt(1, storeID);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int reservationID = rs.getInt("ReservationID");
                    Date reservationDate = rs.getDate("ReservationDate");
                    Time reservationTime = rs.getTime("ReservationTime");
                    int numberOfPeople = rs.getInt("NumberOfPeople");
                    String reservationStatus = rs.getString("ReservationStatus");
                    String userName = rs.getString("UserName");
                    String userPhoneNumber = rs.getString("PhoneNumber");
                    String userID = rs.getString("UserID");

                    // 디버그 로그 추가
                    System.out.println("Debug: ReservationID = " + reservationID + ", UserID = " + userID);
        %>
            <tr>
                <td><%= reservationID %></td>
                <td><%= reservationDate %></td>
                <td><%= reservationTime %></td>
                <td><%= numberOfPeople %></td>
                <td><%= reservationStatus %></td>
                <td><%= (userName != null) ? userName : "" %></td>
                <td><%= (userPhoneNumber != null) ? userPhoneNumber : "" %></td>
                <td>
                    <a href="deleteReservation.jsp?ReservationID=<%= reservationID %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this reservation?');">Delete</a>
                </td>
            </tr>
        <%
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
        </tbody>
    </table>
</div>
</body>
</fmt:bundle>
</html>
