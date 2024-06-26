<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <style>
        .form-container {
            max-width: 400px;
            margin: auto;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %> 
    <div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">개인 회원 로그인</h1>
            <p class="col-md-8 fs-4 mx-auto">Login</p>
        </div>
    </div>
    
    <div class="row justify-content-center">
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
                    <label for="floatingInput">ID</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="floatingPassword" name="password" required>
                    <label for="floatingPassword">Password</label>
                </div>
                <input type="hidden" name="loginType" value="user">
                <div class="d-flex justify-content-between">
                    <button class="btn btn-lg btn-success me-2 flex-grow-1" type="submit">로그인</button>
                    <button type="button" class="btn btn-secondary me-2 flex-grow-1" onclick="location.href='joinpage.jsp'">회원가입</button>
                </div>
            </form>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>
