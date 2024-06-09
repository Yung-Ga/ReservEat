<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 가입 오류</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
</head>
<body>
    <div class="container py-4">
        <h1 class="mb-4">회원 가입 오류</h1>
        <p>회원 가입 중 오류가 발생했습니다. 나중에 다시 시도해 주세요.</p>
        <p><%= request.getParameter("error") %></p>
        <a href="joinForm.jsp" class="btn btn-primary">회원 가입 페이지로 돌아가기</a>
    </div>
</body>
</html>
