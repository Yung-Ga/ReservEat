<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 가입 페이지</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="./resources/js/validation.js"></script>
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
        }
        .custom-image {
            width: 400px; /* 원하는 너비로 변경 */
            height: auto; /* 비율을 유지 */
        }
        .btn-gray {
            background-color: gray;
            color: white;
            border: none;
        }
    </style>
    <script>
        function submitForm(action) {
            var form = document.forms['joinForm'];
            form.action = action;
            form.submit();
        }
    </script>
</head>
<body>
<div class="container py-4">
    <div class="form-container">
        <h1 class="mb-4 text-center">회원 가입 페이지</h1>
        <form name="joinForm" method="post" class="needs-validation" novalidate>
            <div class="mb-3 row">
                <label for="id" class="col-sm-4 col-form-label">아이디:</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" id="id" name="id" class="form-control" maxlength="20" required>
                        <button type="button" class="btn btn-secondary" id="checkIdBtn">중복확인</button>
                    </div>
                    <span id="idCheckResult" class="text-danger"></span>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="pw" class="col-sm-4 col-form-label">비밀번호:</label>
                <div class="col-sm-8">
                    <input type="password" id="pw" name="pw" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="password_confirm" class="col-sm-4 col-form-label">비밀번호 확인:</label>
                <div class="col-sm-8">
                    <input type="password" id="password_confirm" name="password_confirm" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="name" class="col-sm-4 col-form-label">이름:</label>
                <div class="col-sm-8">
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="phone1" class="col-sm-4 col-form-label">전화번호:</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" id="phone1" name="phone1" class="form-control" maxlength="3" required>
                        <input type="text" id="phone2" name="phone2" class="form-control" maxlength="4" required>
                        <input type="text" id="phone3" name="phone3" class="form-control" maxlength="4" required>
                    </div>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="email1" class="col-sm-4 col-form-label">이메일:</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="text" id="email1" name="email1" class="form-control" required>
                        <span class="input-group-text">@</span>
                        <select id="email2" name="email2" class="form-select" required>
                            <option value="직접입력">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="daum.net">daum.net</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="text-center mb-3">
                <img src="./resources/images/회원가입설명.png" alt="Image" class="img-fluid custom-image">
            </div>
            <div class="mb-3 row">
                <div class="col-sm-12 text-center">
                	<input type="submit" class="btn btn-gray" value="회원가입">
                    <button type="submit" class="btn btn-gray" onclick="submitForm('joinpage3.jsp')">소비자</button>
                    <button type="button" class="btn btn-gray" onclick="submitForm('joinpage2.jsp')">사업자</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
    })();

    $(document).ready(function() {
        $('#checkIdBtn').click(function() {
            var id = $('#id').val();
            if (id) {
                $.ajax({
                    url: 'checkId.jsp',
                    type: 'GET',
                    data: { id: id },
                    success: function(response) {
                        try {
                            var result = JSON.parse(response);
                            if (result.isDuplicate) {
                                $('#idCheckResult').text('아이디가 이미 존재합니다.');
                            } else {
                                $('#idCheckResult').text('사용 가능한 아이디입니다.');
                            }
                        } catch (e) {
                            $('#idCheckResult').text('응답을 처리하는 중 오류가 발생했습니다.');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        $('#idCheckResult').text('아이디 중복 확인 중 오류가 발생했습니다: ' + textStatus + ' ' + errorThrown);
                    }
                });
            } else {
                $('#idCheckResult').text('아이디를 입력하세요.');
            }
        });
    });
</script>
</body>
</html>


