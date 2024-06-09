<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }
%>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <script type="text/javascript" src="./resources/js/validation.js"></script>
    <title>가게 등록</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="StoreAddition" /></h1>
            <p class="col-md-8 fs-4">Store Addition</p>
        </div>
    </div>
    
    <div class="row align-items-md-stretch">
        <div class="text-end mb-3">
            <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
            <a href="logout.jsp" class="btn btn-sm btn-success">Logout</a>
        </div>
        <form name="newStore" action="./processAddStore.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
        	<%@ include file = "dbconn.jsp" %>
        	<div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreName" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreName" name="StoreName" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="RegistrationNumber" /></label>
                <div class="col-sm-3">
                    <input type="text" id="RegistrationNumber" name="RegistrationNumber" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="OwnerName" /></label>
                <div class="col-sm-3">
                    <input type="text" id="OwnerName" name="OwnerName" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="District" /></label>
                <div class="col-sm-3">
                    <select id="DistrictID" name="DistrictID" class="form-select">
                        <option value="">Select District</option>
                        <%
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            
                            try {
                                String sql = "SELECT DistrictID, DistrictName FROM District";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                
                                while (rs.next()) {
                                    int districtID = rs.getInt("DistrictID");
                                    String districtName = rs.getString("DistrictName");
                        %>
                        <option value="<%= districtID %>"><%= districtName %></option>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        %>
                    </select>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreAddress" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreAddress" name="StoreAddress" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreNumber" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreNumber" name="StoreNumber" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="OpenTime" /></label>
                <div class="col-sm-3">
                    <input type="text" id="OpenTime" name="OpenTime" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="CloseTime" /></label>
                <div class="col-sm-3">
                    <input type="text" id="CloseTime" name="CloseTime" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="ClosedDay" /></label>
                <div class="col-sm-3">
                    <input type="text" id="ClosedDay" name="ClosedDay" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="Category" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Korean" value="Korean">
                        <label class="form-check-label" for="Korean"><fmt:message key="Category_Korean" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Japanese" value="Japanese">
                        <label class="form-check-label" for="Japanese"><fmt:message key="Category_Japanese" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Chinese" value="Chinese">
                        <label class="form-check-label" for="Chinese"><fmt:message key="Category_Chinese" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Western" value="Western">
                        <label class="form-check-label" for="Western"><fmt:message key="Category_Western" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Asian" value="Asian">
                        <label class="form-check-label" for="Asian"><fmt:message key="Category_Cafe" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Cafe" value="Cafe">
                        <label class="form-check-label" for="Cafe"><fmt:message key="Category_Cafe" /></label>
                    </div>
                </div>
            </div>
            
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="ServiceType" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Delivery" value="Delivery">
                        <label class="form-check-label" for="Delivery"><fmt:message key="ServiceType_Delivery" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Takeout" value="Takeout">
                        <label class="form-check-label" for="Takeout"><fmt:message key="ServiceType_Takeout" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Parking" value="Parking">
                        <label class="form-check-label" for="Parking"><fmt:message key="ServiceType_Parking" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="OutdoorSeating" value="OutdoorSeating">
                        <label class="form-check-label" for="OutdoorSeating"><fmt:message key="ServiceType_OutdoorSeating" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Reservations" value="Reservations">
                        <label class="form-check-label" for="Reservations"><fmt:message key="ServiceType_Reservations" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="WiFi" value="WiFi">
                        <label class="form-check-label" for="WiFi"><fmt:message key="ServiceType_WiFi" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="PetFriendly" value="PetFriendly">
                        <label class="form-check-label" for="PetFriendly"><fmt:message key="ServiceType_PetFriendly" /></label>
                    </div>
                </div>
            </div>
            
             <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="PaymentMethods" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="Cash" value="Cash">
                        <label class="form-check-label" for="Cash"><fmt:message key="PaymentMethods_Cash" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="Card" value="Card">
                        <label class="form-check-label" for="Card"><fmt:message key="PaymentMethods_Card" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="SeoulPay" value="SeoulPay">
                        <label class="form-check-label" for="SeoulPay"><fmt:message key="PaymentMethods_SeoulPay" /></label>
                    </div>
                </div>
            </div>
            
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
            <div class="mb-3 row">
                <div class="offset-sm-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="<fmt:message key='button_insert' />">
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp" />
</div>
</fmt:bundle>
</body>
</html>