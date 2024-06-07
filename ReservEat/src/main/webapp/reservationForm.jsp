<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String storeID = request.getParameter("storeID");
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }
%>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>예약하기</title>
</head>
<body>
<%@ include file="dbconn.jsp" %> <!-- DB 연결 -->

<div class="container py-4">
<%@ include file="menu.jsp" %>

<%    if (storeID == null) {
        out.println("가게 ID가 제공되지 않았습니다.");
    } else {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String storeName = null;
        
        try {
            String sql = "SELECT StoreName FROM Store WHERE StoreID = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, storeID);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                storeName = rs.getString("StoreName");
            } else {
                out.println("가게 정보를 찾을 수 없습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        if (storeName != null) {
%>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            	<h1 class="display-5 fw-bold"><fmt:message key="Reservation" /></h1>
            	<h2><%= storeName %></h2>
        </div>
    </div>
    <div class="row align-items-md-stretch">
    <div class="text-end mb-3">
    	<a href="?language=ko&storeID=<%= storeID %>">한국어</a> | <a href="?language=en&storeID=<%= storeID %>">English</a>
    	<a href="logout.jsp" class="btn btn-sm btn-success">Logout</a>
    </div>
    <form method="post" action="processReservation.jsp">
        <div class="mb-3">
            <label for="reservationDate" class="form-label"><fmt:message key="ReservationDate" /></label>
            <input type="date" name="reservationDate" id="reservationDate" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="reservationTime" class="form-label"><fmt:message key="ReservationTime" /></label>
            <input type="time" name="reservationTime" id="reservationTime" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="numberOfPeople" class="form-label"><fmt:message key="NumberOfPeople" /></label>
            <input type="number" name="numberOfPeople" id="numberOfPeople" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary"><fmt:message key="Reservation" /></button>
    </form>
    </div>
    <%
        }
    }
%>
	<jsp:include page="footer.jsp" />
</div>
</fmt:bundle>
</body>
</html>
