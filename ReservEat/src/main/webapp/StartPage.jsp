<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
<style>
    .btn-custom {
        display: inline-block;
        padding: 0;
        border: none;
        background: none;
        margin: 0 20px; /* 버튼 간격 조정 */
        text-align: center;
    }
    .btn-custom img {
        width: 100px; /* 이미지 크기 조정 */
        height: auto;
    }
    .btn-custom span {
        display: block;
        margin-top: 10px; /* 이미지와 텍스트 간격 조정 */
        font-size: 16px;
        color: black;
    }
</style>
<title>Select a user</title>
</head>
<body>
<div class="container py-4">
<%@ include file="menu.jsp" %> 
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5 text-center"> <!-- 텍스트 중앙 정렬 -->
        <h1 class="display-5 fw-bold">ReservEat</h1>
      </div>
    </div>  
    <div class="text-center"> <!-- 중앙 정렬 -->
        <a href="./login.jsp" class="btn-custom">
            <img src="./resources/images/로그인.png" alt="소비자 버튼">
            <span>소비자</span>
        </a>
        <a href="./storeLogInPage.jsp" class="btn-custom">
            <img src="./resources/images/회원가입.png" alt="사업자 버튼">
            <span>사업자</span>
        </a>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
