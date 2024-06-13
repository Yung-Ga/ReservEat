<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String storeIDParam = request.getParameter("storeID");
String imageType = request.getParameter("type");
String imageTypeKey = "Category_" + (imageType != null ? imageType : "All");
String language = request.getParameter("language");
if (language == null) {
	language = "ko"; // 기본값 설정
}
%>
<fmt:setLocale value="<%=language%>" />
<fmt:bundle basename="bundle.message">
	<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>사진 보기</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<!-- DB 연결 -->

	<div class="container py-4">
		<%@ include file="menu.jsp"%>

		<%
		if (storeIDParam == null) {
			out.println("가게 ID가 제공되지 않았습니다.");
		} else {
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				String sql = "SELECT s.StoreName, i.ImageURL FROM Store s JOIN Image i ON s.StoreID = i.StoreID WHERE s.StoreID = ?";
				if (imageType != null && !imageType.isEmpty()) {
			sql += " AND i.ImageType = ?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(storeIDParam));
				if (imageType != null && !imageType.isEmpty()) {
			pstmt.setString(2, imageType);
				}
				rs = pstmt.executeQuery();

				if (rs.next()) {
			String storeName = rs.getString("StoreName");
		%>
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">
					<fmt:message key="Image" />
					-
					<fmt:message key="<%=imageTypeKey%>" />
				</h1>
				<h2><%=storeName%></h2>
			</div>
		</div>
		<header class="pb-3 mb-4 border-bottom">
			<div class="row align-items-center">
				<div class="col-md-8">
					<ul class="nav nav-pills">
						<li class="nav-item"><a
							href="./showImages.jsp?storeID=<%=storeIDParam%>&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_All" /></a></li>
						<li class="nav-item"><a
							href="./showImages.jsp?storeID=<%=storeIDParam%>&type=food&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_food" /></a></li>
						<li class="nav-item"><a
							href="./showImages.jsp?storeID=<%=storeIDParam%>&type=interior&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_interior" /></a></li>
						<li class="nav-item"><a
							href="./showImages.jsp?storeID=<%=storeIDParam%>&type=exterior&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_exterior" /></a></li>
					</ul>
				</div>
				<div class="col-md-4 text-end">
					<a href="?language=ko&storeID=<%=storeIDParam%>">한국어</a> | <a
						href="?language=en&storeID=<%=storeIDParam%>">English</a> 
						<a href="store.jsp?id=<%=storeIDParam%>" class="btn btn-secondary"><fmt:message
                            key="StoreInfo" /> &raquo;</a>
				</div>
			</div>
		</header>

		<div class="row">
			<%
			do {
				String imageURL = rs.getString("ImageURL");
				System.out.println("URL = " + imageURL);
			%>
			<div class="col-md-4 mb-3">
				<img src="./resources/images/<%=imageURL%>" class="img-fluid"
					alt="Store Image" />
			</div>
			<%
			} while (rs.next());
			} else {
			out.println("이미지를 찾을 수 없습니다.");
			}
			} catch (SQLException e) {
			e.printStackTrace();
			out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
			} finally {
			if (rs != null)
			try {
			rs.close();
			} catch (SQLException e) {
			e.printStackTrace();
			}
			if (pstmt != null)
			try {
			pstmt.close();
			} catch (SQLException e) {
			e.printStackTrace();
			}
			if (conn != null)
			try {
			conn.close();
			} catch (SQLException e) {
			e.printStackTrace();
			}
			}
			}
			%>
		</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</fmt:bundle>
</html>
