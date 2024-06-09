<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
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
    <div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">로그인</h1>
            <p class="col-md-8 fs-4">Login</p>
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
            <form class="form-signin" action="j_security_check" method="post">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingInput" name="j_username" required autofocus>
                    <label for="floatingInput">ID</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="floatingPassword" name="j_password" required>
                    <label for="floatingPassword">Password</label>
                </div>
                <button class="btn btn-lg btn-success w-100" type="submit">로그인</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
