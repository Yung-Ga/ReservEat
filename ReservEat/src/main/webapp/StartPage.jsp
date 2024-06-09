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
<title>Welcome</title>
</head>
<body>
<div class="container py-4">
  <%!String greeting = "ReservEat";
   String tagline = "맛집 찾고 가3";%>   
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5 text-center"> <!-- 텍스트 중앙 정렬 -->
        <h1 class="display-5 fw-bold"><%=greeting%></h1>
        <p class="col-md-8 fs-4 mx-auto">맛집 찾고 가세요!</p> <!-- 중앙 정렬을 위해 mx-auto 클래스 추가 -->
      </div>
    </div>  
    <div class="text-center"> <!-- 중앙 정렬 -->
        <a href="./login.jsp" class="btn-custom">
            <img src="./resources/images/로그인.png" alt="로그인 버튼">
            <span>로그인</span>
        </a>
        <a href="./joinpage.jsp" class="btn-custom">
            <img src="./resources/images/회원가입.png" alt="회원가입 버튼">
            <span>회원가입</span>
        </a>
    </div>
</div>
</body>
</html>

