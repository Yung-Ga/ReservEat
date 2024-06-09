<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <style>
        .btn-gray {
            background-color: gray;
            color: white;
            border: none;
        }
    </style>
    <script>
        function submitForm(action) {
            var form = document.createElement('form');
            form.method = 'post';
            form.action = action;
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    회원가입 성공!
    <button type="button" class="btn btn-gray" onclick="submitForm('login.jsp')">로그인</button>
    <button type="button" class="btn btn-gray" onclick="submitForm('StartPage.jsp')">처음으로</button>
</body>
</html>
