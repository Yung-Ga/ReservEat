<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="dbconn.jsp" %>
<%
    String language = request.getParameter("language");
    if (language == null) {
        language = "ko"; // 기본값 설정
    }

    // DB 연결 설정
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String storeID = request.getParameter("storeID");
    String storeName = "", registrationNumber = "", password = "", phoneNumber = "", ownerName = "", districtID = "", storeAddress = "", storeNumber = "", openTime = "", closeTime = "", closedDay = "", category = "", serviceType = "", paymentMethods = "";

    try {
        String sql = "SELECT * FROM Store WHERE StoreID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, storeID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            storeName = rs.getString("StoreName");
            registrationNumber = rs.getString("RegistrationNumber");
            password = rs.getString("Password");
            phoneNumber = rs.getString("PhoneNumber");
            ownerName = rs.getString("OwnerName");
            districtID = rs.getString("DistrictID");
            storeAddress = rs.getString("StoreAddress");
            storeNumber = rs.getString("StoreNumber");
            openTime = rs.getString("OpenTime");
            closeTime = rs.getString("CloseTime");
            closedDay = rs.getString("ClosedDay");
            category = rs.getString("Category");
            serviceType = rs.getString("ServiceType");
            paymentMethods = rs.getString("PaymentMethods");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<fmt:setLocale value="<%= language %>"/>
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <script type="text/javascript" src="./resources/js/validation.js"></script>
    <title>가게 수정</title>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><fmt:message key="StoreEdit" /></h1>
            <p class="col-md-8 fs-4">Store Edit</p>
        </div>
    </div>
    
    <div class="row align-items-md-stretch">
        <div class="text-end mb-3">
            <a href="?language=ko">한국어</a> | <a href="?language=en">English</a>
        </div>
        <form name="editStore" action="./processEditStore.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
            <input type="hidden" name="StoreID" value="<%= storeID %>" />
            
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreName" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreName" name="StoreName" class="form-control" value="<%= storeName %>" disabled>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="RegistrationNumber" /></label>
                <div class="col-sm-3">
                    <input type="text" id="RegistrationNumber" name="RegistrationNumber" class="form-control" value="<%= registrationNumber %>" disabled>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="Password" /></label>
                <div class="col-sm-3">
                    <input type="password" id="Password" name="Password" class="form-control" value="<%= password %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="PhoneNumber" /></label>
                <div class="col-sm-3">
                    <input type="text" id="PhoneNumber" name="PhoneNumber" class="form-control" value="<%= phoneNumber %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="OwnerName" /></label>
                <div class="col-sm-3">
                    <input type="text" id="OwnerName" name="OwnerName" class="form-control" value="<%= ownerName %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="District" /></label>
                <div class="col-sm-3">
                    <select id="DistrictID" name="DistrictID" class="form-select" required>
                        <option value="">Select District</option>
                        <%
                            try {
                                String sql = "SELECT DistrictID, DistrictName FROM District";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                
                                while (rs.next()) {
                                    int districtIDValue = rs.getInt("DistrictID");
                                    String districtName = rs.getString("DistrictName");
                        %>
                        <option value="<%= districtIDValue %>" <%= districtID.equals(String.valueOf(districtIDValue)) ? "selected" : "" %>><%= districtName %></option>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        %>
                    </select>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreAddress" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreAddress" name="StoreAddress" class="form-control" value="<%= storeAddress %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="StoreNumber" /></label>
                <div class="col-sm-3">
                    <input type="text" id="StoreNumber" name="StoreNumber" class="form-control" value="<%= storeNumber %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="OpenTime" /></label>
                <div class="col-sm-3">
                    <input type="time" id="OpenTime" name="OpenTime" class="form-control" value="<%= openTime %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="CloseTime" /></label>
                <div class="col-sm-3">
                    <input type="time" id="CloseTime" name="CloseTime" class="form-control" value="<%= closeTime %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="ClosedDay" /></label>
                <div class="col-sm-3">
                    <input type="text" id="ClosedDay" name="ClosedDay" class="form-control" value="<%= closedDay %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="Category" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Korean" value="Korean" <%= category.equals("Korean") ? "checked" : "" %>>
                        <label class="form-check-label" for="Korean"><fmt:message key="Category_Korean" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Japanese" value="Japanese" <%= category.equals("Japanese") ? "checked" : "" %>>
                        <label class="form-check-label" for="Japanese"><fmt:message key="Category_Japanese" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Western" value="Western" <%= category.equals("Western") ? "checked" : "" %>>
                        <label class="form-check-label" for="Western"><fmt:message key="Category_Western" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Chinese" value="Chinese" <%= category.equals("Chinese") ? "checked" : "" %>>
                        <label class="form-check-label" for="Chinese"><fmt:message key="Category_Chinese" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Asian" value="Asian" <%= category.equals("Asian") ? "checked" : "" %>>
                        <label class="form-check-label" for="Asian"><fmt:message key="Category_Asian" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="Category" id="Cafe" value="Cafe" <%= category.equals("Cafe") ? "checked" : "" %>>
                        <label class="form-check-label" for="Cafe"><fmt:message key="Category_Cafe" /></label>
                    </div>       
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="ServiceType" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Delivery" value="Delivery" <%= serviceType.contains("Delivery") ? "checked" : "" %>>
                        <label class="form-check-label" for="Delivery"><fmt:message key="ServiceType_Delivery" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Takeout" value="Takeout" <%= serviceType.contains("Takeout") ? "checked" : "" %>>
                        <label class="form-check-label" for="Takeout"><fmt:message key="ServiceType_Takeout" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Parking" value="Parking" <%= serviceType.contains("Parking") ? "checked" : "" %>>
                        <label class="form-check-label" for="Parking"><fmt:message key="ServiceType_Parking" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="OutdoorSeating" value="OutdoorSeating" <%= serviceType.contains("OutdoorSeating") ? "checked" : "" %>>
                        <label class="form-check-label" for="OutdoorSeating"><fmt:message key="ServiceType_OutdoorSeating" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="Reservations" value="Reservations" <%= serviceType.contains("Reservations") ? "checked" : "" %>>
                        <label class="form-check-label" for="Reservations"><fmt:message key="ServiceType_Reservations" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="WiFi" value="WiFi" <%= serviceType.contains("WiFi") ? "checked" : "" %>>
                        <label class="form-check-label" for="WiFi"><fmt:message key="ServiceType_WiFi" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="ServiceType" id="PetFriendly" value="PetFriendly" <%= serviceType.contains("PetFriendly") ? "checked" : "" %>>
                        <label class="form-check-label" for="PetFriendly"><fmt:message key="ServiceType_PetFriendly" /></label>
                    </div>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label"><fmt:message key="PaymentMethods" /></label>
                <div class="col-sm-5">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="Cash" value="Cash" <%= paymentMethods.contains("Cash") ? "checked" : "" %>>
                        <label class="form-check-label" for="Cash"><fmt:message key="PaymentMethods_Cash" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="Card" value="Card" <%= paymentMethods.contains("Card") ? "checked" : "" %>>
                        <label class="form-check-label" for="Card"><fmt:message key="PaymentMethods_Card" /></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="PaymentMethods" id="SeoulPay" value="SeoulPay" <%= paymentMethods.contains("SeoulPay") ? "checked" : "" %>>
                        <label class="form-check-label" for="SeoulPay"><fmt:message key="PaymentMethods_SeoulPay" /></label>
                    </div>
                </div>
            </div>
            <div class="mb-3 row">
                <div class="col-sm-5 offset-sm-2">
                    <button type="submit" class="btn btn-primary"><fmt:message key="button_edit" /></button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
</fmt:bundle>
