<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="menu.jsp" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userPhoneNumber = (String) session.getAttribute("phoneNumber");
    int numberOfPeople = (int) session.getAttribute("numberOfPeople");
    String reservationDate = (String) session.getAttribute("reservationDate");
    String reservationTime = (String) session.getAttribute("reservationTime");
%>

<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>Reservation Success</title>
</head>
<body>
<div class="container py-4">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">Reservation Success</h1>
            <p class="col-md-8 fs-4">Your reservation has been successfully confirmed.</p>
            <p><b>Reservation Details:</b></p>
            <p><b>Name:</b> <%= userName %></p>
            <p><b>Phone Number:</b> <%= userPhoneNumber %></p>
            <p><b>Number of People:</b> <%= numberOfPeople %></p>
            <p><b>Date:</b> <%= reservationDate %></p>
            <p><b>Time:</b> <%= reservationTime %></p>
            <a href="stores.jsp" class="btn btn-primary">Back to Stores</a>
        </div>
    </div>
</div>
</body>
</html>
