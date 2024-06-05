<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<title>회원 가입 페이지</title>
</head>
<body>
	<form name="joinForm" medthod="post" >
		<p>
			<label>아이디: <input type="text" name="id" maxlength="20"></label>
			<input type="button" value="중복확인">
		</p>
		<p>
			<label>비밀번호: <input type="password" name="pw"></label>
		</p>
		<p>
			<label>비밀번호 확인: <input type="text" name="name"></label>
		</p>
		<p>
			<label>이름: <input type="text" name="name"></label>
		</p>
		<p>
			<label>전화번호: <input type="text" name="phone1" maxlength="3" size ="3">-
							<input type="text" name="phone1" maxlength="3" size ="3">-
							<input type="text" name="phone1" maxlength="3" size ="3"></label>
		</p>
		<p>
			<label>이메일: <input type="text" name="email1" size ="10"> @ 
						<select name= "email2">
						<option value="직접입력">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="gmail.com">daum.net</option>
						</select>
			</label>
		</p>
		<p><input type="submit" value="다음으로">
	</form>
</div>
</body>
</html>