<%@ page contentType="text/html; charset=UTF-8"%>
<%
String UserID = request.getParameter("UserID");
if (UserID == null) {
	UserID = "";
	// 여기 로그인 페이지로 넘기는 코드 작성!!
}

String StoreID = request.getParameter("StoreID");

// 업종 선택할 때 사용할 변수
String type = request.getParameter("type");
String storeTypeKey = "Category_" + (type != null ? type : "All");

// 언어 설정 변수
String language = request.getParameter("language");
if (language == null) {
	language = "ko"; // 기본값 설정
}
%>