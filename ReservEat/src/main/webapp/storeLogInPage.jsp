<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
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
    <title>Login</title>
    <style>
        .form-container {
            max-width: 400px;
            margin: auto;
        }
    </style>
</head>
<body>
<div class="container py-4">
<%@ include file="menu.jsp"%>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">사업자 회원 로그인</h1>
        </div>
    </div>
    
    <div class="row justify-content-center">
        <div class="text-end mb-3">
            <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
        </div>
        <div class="form-container">
            <h3 class="mb-4 text-center">Please sign in</h3>
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    out.println("<div class='alert alert-danger'>");
                    out.println("아이디와 비밀번호를 확인해 주세요.");
                    out.println("</div>");
                }
            %>
            <form class="form-signin" action="login" method="post">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingInput" name="identifier" required autofocus>
                    <label for="floatingInput">Registration Number</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="floatingPassword" name="password" required>
                    <label for="floatingPassword">Password</label>
                </div>
                <input type="hidden" name="loginType" value="store">
                <div class="d-flex justify-content-between">
                    <button class="btn btn-lg btn-success me-2 flex-grow-1" type="submit"><fmt:message key="SignIn" /></button>
                    <a href="addStore.jsp" class="btn btn-lg btn-primary ms-2 flex-grow-1"><fmt:message key="SignUp" /></a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</fmt:bundle>
