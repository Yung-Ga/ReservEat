<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="dbconn.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>

<%
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }

    String userID = request.getParameter("userID");
    int storeID = Integer.parseInt(request.getParameter("storeID"));

    // 예약 가능한 날짜 가져오기
    Set<String> availableDates = new HashSet<>();
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT DISTINCT ReservationDate FROM Reservation WHERE StoreID = ? AND UserID IS NULL AND ReservationDate >= CURDATE()";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, storeID);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            availableDates.add(rs.getDate("ReservationDate").toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>예약하기</title>
    <style>
        .reservation-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }
        .calendar {
            display: flex;
            flex-wrap: wrap;
        }
        .calendar div {
            width: 14.28%;
            text-align: center;
            padding: 10px;
            cursor: pointer;
        }
        .calendar .available {
            background-color: #28a745;
            color: white;
        }
        .calendar .unavailable {
            background-color: #ccc;
            color: #777;
            cursor: not-allowed;
        }
        .calendar .selected {
            background-color: #007bff;
            color: white;
        }
        .btn-center {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">
                <fmt:message key="Reservation" />
            </h1>
            <p class="col-md-8 fs-4">Reservation</p>
        </div>
    </div>
    <div class="container reservation-container">
        <form action="reservationForm.jsp" method="get">
            <div class="form-group">
                <h4 class="text-center">날짜 선택</h4>
                <div class="calendar">
                    <%
                    Calendar calendar = Calendar.getInstance();
                    int currentDay = calendar.get(Calendar.DAY_OF_MONTH);
                    int currentMonth = calendar.get(Calendar.MONTH);
                    int currentYear = calendar.get(Calendar.YEAR);
                    calendar.set(currentYear, currentMonth, 1);

                    int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
                    int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

                    for (int i = 0; i < firstDayOfWeek; i++) {
                        out.print("<div></div>");
                    }
                    for (int day = 1; day <= daysInMonth; day++) {
                        String dateStr = currentYear + "-" + String.format("%02d", currentMonth + 1) + "-" + String.format("%02d", day);
                        if (availableDates.contains(dateStr)) {
                            out.print("<div class='day available' data-day='" + dateStr + "'>" + day + "</div>");
                        } else {
                            out.print("<div class='day unavailable'>" + day + "</div>");
                        }
                    }
                    %>
                </div>
                <input type="hidden" name="date" id="selectedDate">
            </div>
            <input type="hidden" name="userID" value="<%= userID %>">
            <input type="hidden" name="storeID" value="<%= storeID %>">
            <div class="btn-center">
                <button type="submit" class="btn btn-primary">시간 확인</button>
            </div>
        </form>
    </div>

    <% if (request.getParameter("date") != null) { %>
    <div class="container reservation-container mt-4">
        <h4 class="text-center">시간 선택</h4>
        <form action="updateReservation.jsp" method="post">
            <div class="form-group">
                <select class="form-control" id="time" name="time" required>
                    <%
                    try {
                        String sql = "SELECT ReservationTime FROM Reservation WHERE StoreID = ? AND ReservationDate = ? AND UserID IS NULL";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, storeID);
                        pstmt.setDate(2, java.sql.Date.valueOf(request.getParameter("date")));
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            Time availableTime = rs.getTime("ReservationTime");
                            out.print("<option value='" + availableTime + "'>" + availableTime + "</option>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </select>
            </div>
            <input type="hidden" name="userID" value="<%= userID %>">
            <input type="hidden" name="storeID" value="<%= storeID %>">
            <input type="hidden" name="date" value="<%= request.getParameter("date") %>">
            <div class="form-group">
                <h4 class="text-center">인원 입력</h4>
                <input type="number" class="form-control" id="numberOfPeople" name="numberOfPeople" min="1" required>
            </div>
            <div class="btn-center">
                <button type="submit" class="btn btn-primary">예약</button>
            </div>
        </form>
    </div>
    <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $('.calendar .available').on('click', function() {
            $('.calendar .day').removeClass('selected');
            $(this).addClass('selected');
            $('#selectedDate').val($(this).data('day'));
        });

        var selectedDate = '<%= request.getParameter("date") %>';
        if (selectedDate) {
            $('.calendar .day[data-day="' + selectedDate + '"]').addClass('selected');
        }
    });
</script>
</body>
</html>
</fmt:bundle>
