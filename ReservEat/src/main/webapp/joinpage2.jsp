<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<title>식당 정보 입력</title>
</head>
<body>
	<form name="joinForm" medthod="post" >
		<p>식당명: <input type="text" name="placename" maxlength="20">
			<input type="button" value="중복확인">
		<p>가게 번호: <input type="text" name="placenumber1" maxlength="3" size ="3">-
							<input type="text" name="placenumber2" maxlength="4" size ="4">-
							<input type="text" name="placenumber3" maxlength="4" size ="4">
		<p><label>주소: <input type="text" name="address1" placeholder = "우펴번호를 입력하세요">
		<p><input type="text" name="address2" placeholder = "주소를 입력하세요" >
		<p><input type="text" name="address3" placeholder = "상세주소를 입력하세요">
		<p>식당 안내:<textarea name="comment" cols="30" rows="3" placeholder = "식당을 소개해주세요!"></textarea>
		<p><input type="submit" value="회원가입">
	</form>
</div>
</body>
</html>