<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>식당 정보 입력</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
        }
        .btn-gray {
            background-color: gray;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="form-container">
        <h1 class="mb-4 text-center">식당 정보 입력</h1>
        <form name="joinForm" method="post">
            <div class="mb-3 row">
                <label for="placename" class="col-sm-4 col-form-label">식당명:</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" id="placename" name="placename" class="form-control" maxlength="20" required>
                    </div>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="placenumber1" class="col-sm-4 col-form-label">가게 번호:</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" id="placenumber1" name="placenumber1" class="form-control" maxlength="3" size="3" required>
                        <span class="input-group-text">-</span>
                        <input type="text" id="placenumber2" name="placenumber2" class="form-control" maxlength="4" size="4" required>
                        <span class="input-group-text">-</span>
                        <input type="text" id="placenumber3" name="placenumber3" class="form-control" maxlength="4" size="4" required>
                    </div>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="address1" class="col-sm-4 col-form-label">주소:</label>
                <div class="col-sm-8">
                    <input type="text" id="address1" name="address1" class="form-control" placeholder="우편번호를 입력하세요" required>
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-8 offset-sm-4">
                    <input type="text" id="address2" name="address2" class="form-control mb-2" placeholder="주소를 입력하세요" required>
                    <input type="text" id="address3" name="address3" class="form-control" placeholder="상세주소를 입력하세요" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="comment" class="col-sm-4 col-form-label">식당 안내:</label>
                <div class="col-sm-8">
                    <textarea id="comment" name="comment" class="form-control" cols="30" rows="3" placeholder="식당을 소개해주세요!" required></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-12 text-center">
                    <input type="submit" class="btn btn-gray" value="회원가입">
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
