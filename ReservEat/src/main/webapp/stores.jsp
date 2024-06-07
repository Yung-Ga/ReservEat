<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String type = request.getParameter("type");
String language = request.getParameter("language");
String storeType = "All";
if (language == null) {
	language = "ko"; // 기본값 설정
}
String storeTypeKey = "Category_" + (type != null ? type : "All");
%>
<fmt:setLocale value="<%=language%>" />
<fmt:bundle basename="bundle.message">
	<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title><fmt:message key="StoreList" /></title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<!-- DB 연결 -->

	<div class="container py-4">
		<%@ include file="menu.jsp"%>

		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">
					<fmt:message key="StoreList" /> - <fmt:message key="<%=storeTypeKey%>" />
				</h1>
				<p class="col-md-8 fs-4">Store List</p>
			</div>
		</div>
		<header class="pb-3 mb-4 border-bottom">
			<div class="row align-items-center">
				<div class="col-md-8">
					<ul class="nav nav-pills">
						<li class="nav-item"><a
							href="./stores.jsp?language=<%=language%>" class="nav-link"><fmt:message
									key="Category_All" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Korean&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Korean" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Japanese&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Japanese" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Chinese&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Chinese" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Western&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Western" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Asian&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Asian" /></a></li>
						<li class="nav-item"><a
							href="./stores.jsp?type=Cafe&language=<%=language%>"
							class="nav-link"><fmt:message key="Category_Cafe" /></a></li>
					</ul>
				</div>
				<div class="col-md-4 text-end">
					<a href="?language=ko&type=<%=type%>">한국어</a> | <a
						href="?language=en&type=<%=type%>">English</a> <a
						href="logout.jsp" class="btn btn-sm btn-success">Logout</a>
				</div>
			</div>
		</header>
		<div class="row align-items-md-stretch text-center">
			<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean hasStores = false;

			try {
				String sql = "SELECT StoreID, StoreName, MainImage, Category FROM Store";
				if (type != null && !type.isEmpty()) {
					sql += " WHERE Category = ?";
				}
				pstmt = conn.prepareStatement(sql);
				if (type != null && !type.isEmpty()) {
					pstmt.setString(1, type);
				}
				rs = pstmt.executeQuery();

				while (rs.next()) {
					hasStores = true;
					int storeID = rs.getInt("StoreID");
					String storeName = rs.getString("StoreName");
					String mainImage = rs.getString("MainImage");
					String category = rs.getString("Category");
			%>
			<div class="col-md-4">
				<div class="h-100 p-2 rounded-3">
					<img src="./resources/images/<%=mainImage%>"
						style="width: 350px; height: 350px" />
					<h5>
						<b><%=storeName%></b>
					</h5>
					<p><%=category%></p>
					<a href="store.jsp?id=<%=storeID%>" class="btn btn-secondary"><fmt:message
							key="button_details" /> &raquo;</a>
				</div>
			</div>
			<%
			}
			if (!hasStores) {
			%>
			<div class="col-12">
				<p>현재 등록된 가게가 없습니다.</p>
			</div>
			<%
			}
			} catch (SQLException e) {
			e.printStackTrace();
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
			%>
		</div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</fmt:bundle>
</html>
