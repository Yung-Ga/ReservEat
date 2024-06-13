<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 가입 성공</title>
   <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>
<body>
<div class="container py-4">
  <%!String greeting = "회원가입 성공!";%>   
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5 text-center"> <!-- 텍스트 중앙 정렬 -->
        <h1 class="display-5 fw-bold"><%=greeting%></h1>
        <p class="col-md-8 fs-4 mx-auto">로그인을 해주세요!</p> <!-- 중앙 정렬을 위해 mx-auto 클래스 추가 -->
      </div>
    </div>  
    <div class="text-center"> <!-- 중앙 정렬 -->
    <input type="button" value="로그인" class="btn btn-gray" onclick="location.href='login.jsp'">
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
