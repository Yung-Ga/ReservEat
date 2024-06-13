<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="dbconn.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    // 가게의 영업 시간을 가져옵니다
    String openTime = null;
    String closeTime = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT OpenTime, CloseTime FROM Store WHERE StoreID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, storeID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            openTime = rs.getString("OpenTime");
            closeTime = rs.getString("CloseTime");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    
    // 시간 선택 옵션을 생성합니다
    StringBuilder timeOptions = new StringBuilder();
    if (openTime != null && closeTime != null) {
        try {
            java.sql.Time startTime = java.sql.Time.valueOf(openTime);
            java.sql.Time endTime = java.sql.Time.valueOf(closeTime);
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(startTime);

            while (calendar.getTime().before(endTime)) {
                java.sql.Time currentTime = new java.sql.Time(calendar.getTime().getTime());
                timeOptions.append("<div class='form-check'>")
                           .append("<input class='form-check-input' type='checkbox' name='availableTimes' value='")
                           .append(currentTime.toString())
                           .append("' id='time-")
                           .append(currentTime.toString().replace(":", "-"))
                           .append("'>")
                           .append("<label class='form-check-label' for='time-")
                           .append(currentTime.toString().replace(":", "-"))
                           .append("'>")
                           .append(currentTime.toString())
                           .append("</label></div>");
                calendar.add(java.util.Calendar.HOUR_OF_DAY, 1); // 1시간 단위로 증가
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title><fmt:message key="SetReservationAvailability" /></title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="SetReservationAvailability" /></h1>
            <p class="col-md-8 fs-4">Set reservation availability for your store.</p>
        </div>
    </div>

    <div class="text-end mb-3">
        <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
    </div>
    
    <form action="saveReservation.jsp?storeID=<%= storeID %>" method="post">
        <div class="mb-3 row">
            <label for="availableDate" class="col-sm-2 col-form-label"><fmt:message key="AvailableDate" /></label>
            <div class="col-sm-3">
                <input type="date" id="availableDate" name="availableDate" class="form-control" required>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="availableTimes" class="col-sm-2 col-form-label"><fmt:message key="AvailableTimes" /></label>
            <div class="col-sm-3">
                <%= timeOptions.toString() %>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="restrictionDetails" class="col-sm-2 col-form-label"><fmt:message key="RestrictionDetails" /></label>
            <div class="col-sm-5">
                <textarea id="restrictionDetails" name="restrictionDetails" class="form-control" rows="4"></textarea>
            </div>
        </div>

        <div class="mb-3 row">
            <div class="offset-sm-2 col-sm-10">
                <input type="submit" class="btn btn-primary" value="Save">
            </div>
        </div>
    </form>
</div>
</fmt:bundle>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
