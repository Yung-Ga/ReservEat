<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String type = request.getParameter("type");
String language = request.getParameter("language");
String district = request.getParameter("district");

if (language == null) {
    language = "ko"; // 기본값 설정
}

if (district == null || district.equals("null") || district.isEmpty()) {
    district = "All";
}
if (type == null || type.equals("null") || type.isEmpty()) {
    type = "All";
}
String storeTypeKey = "Category_" + type;
String districtKey = !district.equals("All") ? district : "전체";

%>
<fmt:setLocale value="<%=language%>" />
<fmt:bundle basename="bundle.message">
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title><fmt:message key="StoreList" /></title>
    <style>
        .img-container {
            width: 100%;
            padding-top: 100%;
            position: relative;
        }
        .img-container img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; 
        }
    </style>
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
                <p class="col-md-8 fs-4">Store List - <%=districtKey%></p>
            </div>
        </div>
        <header class="pb-3 mb-4 border-bottom">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <form method="get" action="stores.jsp">
                        <select name="district" onchange="this.form.submit()">
                            <option value="All">전체</option>
                            <% 
                            PreparedStatement districtStmt = conn.prepareStatement("SELECT DistrictID, DistrictName FROM District");
                            ResultSet districtRs = districtStmt.executeQuery();
                            while (districtRs.next()) {
                                int districtID = districtRs.getInt("DistrictID");
                                String districtName = districtRs.getString("DistrictName");
                            %>
                            <option value="<%=districtID%>" <%= (district != null && district.equals(String.valueOf(districtID))) ? "selected" : "" %>><%=districtName%></option>
                            <% } districtRs.close(); districtStmt.close(); %>
                        </select>
                        <input type="hidden" name="language" value="<%=language%>" />
                    </form>
                    <ul class="nav nav-pills">
                        <li class="nav-item"><a href="./stores.jsp?district=All&language=<%=language%>" class="nav-link"><fmt:message key="Category_All" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Korean&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Korean" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Japanese&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Japanese" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Chinese&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Chinese" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Western&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Western" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Asian&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Asian" /></a></li>
                        <li class="nav-item"><a href="./stores.jsp?type=Cafe&district=<%=district%>&language=<%=language%>" class="nav-link"><fmt:message key="Category_Cafe" /></a></li>
                    </ul>
                </div>
                <div class="col-md-4 text-end">
                    <a href="?language=ko&type=<%=type%>&district=<%=district%>">한국어</a> | <a href="?language=en&type=<%=type%>&district=<%=district%>">English</a> 
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
                if ((type != null && !type.equals("All")) || (district != null && !district.equals("All"))) {
                    sql += " WHERE";
                    if (type != null && !type.equals("All")) {
                        sql += " Category = ?";
                    }
                    if (district != null && !district.equals("All")) {
                        if (type != null && !type.equals("All")) {
                            sql += " AND";
                        }
                        sql += " DistrictID = ?";
                    }
                }

                pstmt = conn.prepareStatement(sql);
                int paramIndex = 1;
                if (type != null && !type.equals("All")) {
                    pstmt.setString(paramIndex++, type);
                }
                if (district != null && !district.equals("All")) {
                    pstmt.setInt(paramIndex++, Integer.parseInt(district));
                }

                rs = pstmt.executeQuery();

                while (rs.next()) {
                    hasStores = true;
                    int currentStoreID = rs.getInt("StoreID");
                    String storeName = rs.getString("StoreName");
                    String mainImage = rs.getString("MainImage");
                    String category = rs.getString("Category");
            %>
            <div class="col-md-4">
                <div class="h-100 p-2 rounded-3">
                    <div class="img-container">
                        <img src="./resources/images/<%=mainImage%>" alt="Store Image"/>
                    </div>
                    <h5>
                        <b><%=storeName%></b>
                    </h5>
                    <p><%=category%></p>
                    <a href="store.jsp?id=<%=currentStoreID%>" class="btn btn-secondary"><fmt:message key="button_details" /> &raquo;</a>
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
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            %>
        </div>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</fmt:bundle>
</html>
