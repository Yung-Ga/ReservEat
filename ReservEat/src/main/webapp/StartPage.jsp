<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Welcome</title>
</head>
<body>
<div class="container py-4">
  <%!String greeting = "ReservEat";
   String tagline = "맛집 찾고 가3";%>   
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold"><%=greeting%></h1>
        <p class="col-md-8 fs-4">안녕</p>      
      </div>
    </div>  
	<p><input type ="button" value="로그인">
</body>
</html>
