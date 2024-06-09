<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>가게 상세 정보</title>
</head>
<body>
<%@ include file="dbconn.jsp" %> <!-- DB 연결 -->

<div class="container py-4">
    <%@ include file="menu.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">가게 정보</h1>
            <p class="col-md-8 fs-4">Store Info</p>      
        </div>
    </div>
    <%
        String storeID = request.getParameter("id");
        if (storeID == null) {
            out.println("가게 ID가 제공되지 않았습니다.");
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
        <div class="col-md-5">
            <img src="./resources/images/<%= rs.getString("MainImage") %>" style="width: 350px; height:450px" alt="Store Image" /> <!-- 이미지 경로 수정 필요 -->
        </div>        
        <div class="col-md-6">
            <h3><b><%=rs.getString("StoreName")%></b></h3>
            <p><b>대표자 이름 : </b> <%=rs.getString("OwnerName")%></p>   
            <p><b>주소 : </b> <%=rs.getString("DistrictName")%> <%=rs.getString("StoreAddress")%></p>
            <p><b>전화번호 : </b> <%=rs.getString("StoreNumber")%></p>
            <p><b>분류 : </b> <%=rs.getString("Category")%></p>
            <p><b>오픈 시간 : </b> <%=rs.getString("OpenTime")%></p>
            <p><b>닫는 시간 : </b> <%=rs.getString("CloseTime")%></p>
            <p><b>휴일 : </b> <%=rs.getString("ClosedDay")%></p>
            <p><b>서비스 유형 : </b> <%=rs.getString("ServiceType")%></p>
            <form name="addForm" action="./addCart.jsp?id=<%=rs.getString("StoreID")%>" method="post">
                <a href="./stores.jsp" class="btn btn-primary"> 메뉴보기 &raquo;</a>
                <a href="./showImages.jsp?storeID=<%=rs.getString("StoreID")%>" class="btn btn-info"> 사진보기 &raquo;</a>
                <a href="./reservationForm.jsp?storeID=<%=storeID%>" class="btn btn-warning"> 예약하기 &raquo;</a> 
                <a href="./stores.jsp" class="btn btn-secondary"> 가게목록 &raquo;</a>
            </form>
        </div>
    </div>
    <%
                } else {
                    out.println("가게 정보를 찾을 수 없습니다.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
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
</html>