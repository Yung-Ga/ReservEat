<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<title>개인 정보 입력</title>
</head>
<body>
	<form name="joinForm" medthod="post" >
		<p>아이디: <input type="text" name="id" maxlength="20">
			<input type="button" value="중복확인">
		<p>비밀번호: <input type="password" name="pw">
		<p>비밀번호 확인: <input type="text" name="name">
		<p>이름: <input type="text" name="name">
		<p>전화번호: <input type="text" name="phone1" maxlength="3" size ="3">-
							<input type="text" name="phone1" maxlength="4" size ="4">-
							<input type="text" name="phone1" maxlength="4" size ="4">
		<p>이메일: <input type="text" name="email1" size ="10"> @ 
						<select name= "email2">
						<option value="직접입력">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="gmail.com">daum.net</option>
						</select>
		<p><input type="submit" value="다음으로">
	</form>
</div>
</body>
</html>
