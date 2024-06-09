<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }
%>
<script type="text/javascript"> 
	function addImage() {
		if (confirm("사진을 등록하시겠습니까?")) {
			document.addForm.submit();
		} else {		
			document.addForm.reset();
		}
	}
</script>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title><fmt:message key="BusinessPage" /></title>
    <script type="text/javascript">
        function confirmAction(event, message) {
            event.preventDefault();
            if (confirm(message)) {
                document.actionForm.submit();
            } else {
                document.actionForm.reset();
            }
        }
    </script>
</head>
<body>
<%@ include file="dbconn.jsp" %> <!-- DB 연결 -->

<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="BusinessPage" /></h1>
            <p class="col-md-8 fs-4">Business Page</p>
        </div>
    </div>
    <%
        String storeID = "5";
        if (storeID == null) {
            out.println("<fmt:message key='error.noStoreID' />");
        } else {
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                String sql = "SELECT s.*, d.DistrictName FROM Store s JOIN District d ON s.DistrictID = d.DistrictID WHERE StoreID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, storeID);
                rs = pstmt.executeQuery();

                if (rs.next()) {
    %>
    <div class="row align-items-md-stretch">
        <div class="text-end mb-3">
            <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
            <a href="logout.jsp" class="btn btn-sm btn-success"><fmt:message key="button_logout" /></a>
        </div>
        <div class="col-md-5">
            <img src="./resources/images/<%= rs.getString("MainImage") %>" style="width: 350px; height:450px" alt="Store Image" /> <!-- 이미지 경로 수정 필요 -->
        </div>
        <div class="col-md-6">
            <h3><b><%= rs.getString("StoreName") %></b></h3>
            <p><b><fmt:message key="OwnerName" /> : </b> <%= rs.getString("OwnerName") %></p>
            <p><b><fmt:message key="StoreAddress" /> : </b> <%= rs.getString("DistrictName") %> <%= rs.getString("StoreAddress") %></p>
            <p><b><fmt:message key="StoreNumber" /> : </b> <%= rs.getString("StoreNumber") %></p>
            <p><b><fmt:message key="Category" /> : </b> <%= rs.getString("Category") %></p>
            <p><b><fmt:message key="OpenTime" /> : </b> <%= rs.getString("OpenTime") %></p>
            <p><b><fmt:message key="CloseTime" /> : </b> <%= rs.getString("CloseTime") %></p>
            <p><b><fmt:message key="ClosedDay" /> : </b> <%= rs.getString("ClosedDay") %></p>
            <p><b><fmt:message key="ServiceType" /> : </b> <%= rs.getString("ServiceType") %></p>
            <p><b><fmt:message key="PaymentMethods" /> : </b> <%= rs.getString("PaymentMethods") %></p>
            <form name="addForm" action="./addImage.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
                <input type="hidden" name="storeID" value="<%= storeID %>" />
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label"><fmt:message key="ImageType" /></label>
                    <div class="col-sm-3">
                        <select id="ImageType" name="ImageType" class="form-select">
                            <option value="Food"><fmt:message key="Category_food" /></option>
                            <option value="Interior"><fmt:message key="Category_interior" /></option>
                            <option value="Exterior"><fmt:message key="Category_exterior" /></option>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label"><fmt:message key="Image" /></label>
                	<div class="col-sm-5">
                    	<input type="file" name="Image" class="form-control">
                	</div>
                </div>
                <button type="submit" class="btn btn-primary" onClick="addImage()"><fmt:message key="button_insert" />&raquo;</button>
            </form>
            <form name="actionForm" action="deleteStore.jsp" method="post">
                <input type="hidden" name="storeID" value="<%= storeID %>" />
                <button type="button" class="btn btn-danger" onClick="confirmAction(event, '<fmt:message key="message.confirmDelete" />')"><fmt:message key="button_delete" /> &raquo; </button>
            </form>
        </div>
    </div>
    <%
                } else {
                    out.println("<fmt:message key='error.storeNotFound' />");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<fmt:message key='error.database' />: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
    <jsp:include page="footer.jsp" />
</div>
</fmt:bundle>
</body>
</html>