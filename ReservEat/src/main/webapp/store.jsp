<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String requestedStoreID = request.getParameter("id");
String language = request.getParameter("language");
int currentStoreID = Integer.parseInt(requestedStoreID);
if (language == null) {
    language = "ko"; // 기본값 설정
}
%>
<fmt:setLocale value="<%=language%>" />
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title><fmt:message key="StoreInfo" /></title>
    <style>
        #map {
            height: 400px;
            width: 500px;
        }
    </style>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=kmzg0h6n4j&submodules=geocoder"></script>
</head>
<body>
<%@ include file="dbconn.jsp" %> 

<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="StoreInfo" /></h1>
            <p class="col-md-8 fs-4">Store Info</p>
        </div>
    </div>
    <%
        if (requestedStoreID == null) {
            out.println("<fmt:message key='StoreIDNotProvided' />");
        } else {
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String storeAddress = null;

            try {
                String sql = "SELECT s.*, d.DistrictName FROM Store s JOIN District d ON s.DistrictID = d.DistrictID WHERE StoreID = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(requestedStoreID));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    storeAddress = rs.getString("StoreAddress");
    %>
    <script>
        var map = null;

        function initMap() {
            map = new naver.maps.Map('map', {
                zoom: 15,
                center: new naver.maps.LatLng(37.5665, 126.9780)
            });

            var address = '<%= rs.getString("DistrictName") %> <%= rs.getString("StoreAddress") %>';
            console.log("Geocoding address: " + address);

            naver.maps.Service.geocode({ query: address }, function(status, response) {
                if (status !== naver.maps.Service.Status.OK) {
                    console.error('Geocode was not successful for the following reason: ' + status);
                    return;
                }

                if (response.v2.addresses.length === 0) {
                    console.error('No result.');
                    return;
                }

                var result = response.v2.addresses[0];
                console.log("Geocode result: ", result); // 디버깅 메시지
                var location = new naver.maps.LatLng(result.y, result.x);

                map.setCenter(location);

                var marker = new naver.maps.Marker({
                    map: map,
                    position: location
                });
            });
        }
    </script>
    <body onload="initMap()">

    <div class="row align-items-md-stretch">
        <div class="text-end mb-3">
            <a href="?language=ko&&id=<%=currentStoreID%>">한국어</a> | <a href="?language=en&&id=<%=currentStoreID%>">English</a>
        </div>
        <div class="row justify-content-center">
        	<div class="col-md-5">
	            <h3><b><%= rs.getString("StoreName") %></b></h3>
    	        <p><b><fmt:message key="OwnerName" /> : </b> <%= rs.getString("OwnerName") %></p>
        	    <p><b><fmt:message key="StoreAddress" /> : </b> <%= rs.getString("DistrictName") %> <%= rs.getString("StoreAddress") %></p>
            	<p><b><fmt:message key="StoreNumber" /> : </b> <%= rs.getString("StoreNumber") %></p>
	            <p><b><fmt:message key="Category" /> : </b> <%= rs.getString("Category") %></p>
    	        <p><b><fmt:message key="OpenTime" /> : </b> <%= rs.getString("OpenTime") %></p>
        	    <p><b><fmt:message key="CloseTime" /> : </b> <%= rs.getString("CloseTime") %></p>
            	<p><b><fmt:message key="ClosedDay" /> : </b> <%= rs.getString("ClosedDay") %></p>
            	<p><b><fmt:message key="ServiceType" /> : </b> <%= rs.getString("ServiceType") %></p>
            	<form name="addForm" action="./addCart.jsp?id=<%= rs.getString("StoreID") %>" method="post">
                	<a href="./stores.jsp" class="btn btn-primary"> 메뉴보기 &raquo;</a>
	                <a href="./showImages.jsp?storeID=<%= rs.getString("StoreID") %>" class="btn btn-info"> 사진보기 &raquo;</a>
    	            <a href="./reservationForm.jsp?storeID=<%=requestedStoreID%>" class="btn btn-warning"> 예약하기 &raquo;</a> 
        	        <a href="./stores.jsp" class="btn btn-secondary"> 가게목록 &raquo;</a>
            	</form>
        	</div>
        <div id="map"></div>
        </div>
    </div>
    
    <%
                } else {
                    out.println("<fmt:message key='StoreNotFound' />");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<fmt:message key='DatabaseError' />: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
    <jsp:include page="footer.jsp" />
</div>
</body>
</fmt:bundle>
</html>
