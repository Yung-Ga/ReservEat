<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="DBconnect.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 가입 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	// 회원가입 화면의 입력값들을 검사한다.
	function checkValue() {
		try {
			var form = document.userInfo;
			var userIdPattern = /^[a-z0-9]+$/; // 소문자와 숫자 조합
			var passwordPattern = /^[a-z0-9]+$/; // 소문자와 숫자 조합

			if (!form.UserID.value) {
				throw "아이디를 입력하세요.";
			}

			if (!userIdPattern.test(form.UserID.value)) {
				throw "아이디는 소문자와 숫자만 입력 가능합니다.";
			}

			if (form.idDuplication.value != "idCheck") {
				throw "아이디 중복체크를 해주세요.";
			}

			if (!form.Password.value) {
				throw "비밀번호를 입력하세요.";
			}

			if (!passwordPattern.test(form.Password.value)) {
				throw "비밀번호는 소문자와 숫자만 입력 가능합니다.";
			}

			if (form.Password.value != form.passwordcheck.value) {
				throw "비밀번호를 동일하게 입력하세요.";
			}

			if (!form.UserName.value) {
				throw "이름을 입력하세요.";
			}

			if (!form.birthyy.value) {
				throw "년도를 입력하세요.";
			}

			if (isNaN(form.birthyy.value)) {
				throw "년도는 숫자만 입력 가능합니다.";
			}

			if (form.birthmm.value == "00") {
				throw "월을 선택하세요.";
			}

			if (!form.birthdd.value) {
				throw "날짜를 입력하세요.";
			}

			if (isNaN(form.birthdd.value)) {
				throw "날짜는 숫자만 입력 가능합니다.";
			}

			if (!form.mail1.value) {
				throw "메일 주소를 입력하세요.";
			}

			if (!form.PhoneNumber.value) {
				throw "전화번호를 입력하세요.";
			}

			if (isNaN(form.PhoneNumber.value)) {
				throw "전화번호는 - 제외한 숫자만 입력 가능합니다.";
			}

			if (!form.Address.value) {
				throw "주소를 입력하세요.";
			}

			// 모든 검사를 통과한 경우 true를 반환하여 폼이 제출되도록 한다.
			return true;
		} catch (error) {
			// 에러 메시지를 경고창으로 표시한다.
			alert(error);
			return false;
		}
	}

	// 아이디 중복체크
	function checkId() {
		var UserID = document.getElementById("UserID").value;
		if (UserID) {
			$
					.ajax({
						url : 'checkId.jsp',
						type : 'GET',
						data : {
							UserID : UserID
						},
						success : function(response) {
							console.log("AJAX 응답: ", response); // 응답 확인
							response = response.trim(); // 응답에서 공백 제거
							if (response === "true") {
								alert("아이디가 중복되었습니다. 다른 아이디를 입력하세요.");
								document.getElementById("idDuplication").value = "";
							} else if (response === "false") {
								alert("사용 가능한 아이디입니다.");
								document.getElementById("idDuplication").value = "idCheck";
							} else {
								alert("서버 오류가 발생했습니다.");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log("AJAX 오류: ", textStatus, errorThrown);
							alert("AJAX 요청 중 오류가 발생했습니다.");
						}
					});
		} else {
			alert("아이디를 입력하세요.");
		}
	}

	// 아이디 입력 시 중복 확인 초기화
	function inputIdChk() {
		document.getElementById("idDuplication").value = "idUncheck";
	}

	// 취소 버튼 클릭 시 초기 화면으로 이동
	function goFirstForm() {
		window.location.href = "index.jsp"; // 초기 화면으로 이동하는 URL로 변경
	}
</script>
</head>
<body>
	<div class="container py-4">
		<%@ include file="menu.jsp"%>
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">회원 가입 페이지</h1>
			</div>
		</div>
		<div class="d-flex justify-content-center">
			<div class="form-container">
				<form name="userInfo" action="processJoin.jsp" method="post"
					onsubmit="return checkValue()" novalidate>
					<div class="mb-3 row">
						<label for="UserID" class="col-sm-4 col-form-label">아이디:</label>
						<div class="col-sm-8">
							<input type="text" id="UserID" name="UserID" class="form-control"
								maxlength="50" onkeydown="inputIdChk()" required> <input
								type="button" value="중복확인" class="btn btn-secondary mt-2"
								onclick="checkId()"> <input type="hidden"
								id="idDuplication" name="idDuplication" value="idUncheck">
							<!-- ID 추가 -->
							<div class="invalid-feedback">아이디를 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="Password" class="col-sm-4 col-form-label">비밀번호:</label>
						<div class="col-sm-8">
							<input type="password" id="Password" name="Password"
								class="form-control" maxlength="50" required>
							<div class="invalid-feedback">비밀번호를 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="passwordcheck" class="col-sm-4 col-form-label">비밀번호
							확인:</label>
						<div class="col-sm-8">
							<input type="password" id="passwordcheck" name="passwordcheck"
								class="form-control" maxlength="50" required>
							<div class="invalid-feedback">비밀번호 확인을 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="UserName" class="col-sm-4 col-form-label">이름:</label>
						<div class="col-sm-8">
							<input type="text" id="UserName" name="UserName"
								class="form-control" maxlength="50" required>
							<div class="invalid-feedback">이름을 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label class="col-sm-4 col-form-label">성별:</label>
						<div class="col-sm-8">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="Gender"
									id="male" value="M" checked> <label
									class="form-check-label" for="male">남</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="Gender"
									id="female" value="F"> <label class="form-check-label"
									for="female">여</label>
							</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="BirthYY" class="col-sm-4 col-form-label">생년월일:</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" id="BirthYY" name="BirthYY"
									class="form-control" maxlength="4" placeholder="년(4자)" required>
								<select id="BirthMM" name="BirthMM" class="form-select" required>
									<option value="00">월</option>
									<option value="01">1</option>
									<option value="02">2</option>
									<option value="03">3</option>
									<option value="04">4</option>
									<option value="05">5</option>
									<option value="06">6</option>
									<option value="07">7</option>
									<option value="08">8</option>
									<option value="09">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select> <input type="text" id="BirthDD" name="BirthDD"
									class="form-control" maxlength="2" placeholder="일" required>
							</div>
							<div class="invalid-feedback">생년월일을 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="mail1" class="col-sm-4 col-form-label">이메일:</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" id="mail1" name="mail1" class="form-control"
									required> <span class="input-group-text">@</span> <select
									id="mail2" name="mail2" class="form-select" required>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
								</select>
							</div>
							<div class="invalid-feedback">이메일을 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="PhoneNumber" class="col-sm-4 col-form-label">휴대전화:</label>
						<div class="col-sm-8">
							<input type="text" id="PhoneNumber" name="PhoneNumber"
								class="form-control" required>
							<div class="invalid-feedback">전화번호를 입력하세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="Address" class="col-sm-4 col-form-label">주소:</label>
						<div class="col-sm-8">
							<input type="text" id="Address" name="Address"
								class="form-control" required>
							<div class="invalid-feedback">주소를 입력하세요.</div>
						</div>
					</div>
					<div class="text-center mb-3">
						<input type="submit" value="가입" class="btn btn-gray"> <input
							type="button" value="취소" class="btn btn-gray"
							onclick="goFirstForm()">
					</div>
				</form>
			</div>
		</div>
		<%@ include file="footer.jsp"%>
	</div>
	<script>
		(function() {
			'use strict';
			var forms = document.querySelectorAll('.needs-validation');
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated');
				}, false);
			});
		})();

		// 아이디 입력 시 중복 확인 초기화
		function inputIdChk() {
			document.getElementById("idDuplication").value = "idUncheck";
		}

		// 취소 버튼 클릭 시 초기 화면으로 이동
		function goFirstForm() {
			window.location.href = "StartPage.jsp"; // 초기 화면으로 이동하는 URL로 변경
		}
	</script>
</body>
</html>
