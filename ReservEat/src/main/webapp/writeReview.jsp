<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="DBconnect.jsp" %>
<%
    String userID = (String) session.getAttribute("userID");
    String storeID = request.getParameter("storeID");
    String storeName = request.getParameter("storeName");
    System.out.println("writeReview UserID: " + userID);
    System.out.println("writeReview StoreID: " + storeID);
    System.out.println("writeReview storeName: " + storeName);
    
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">리뷰 작성</h1>
            <h3><%= storeName %></h3>
        </div>
    </div>
    <form action="submitReview" method="post" enctype="multipart/form-data">
        <input type="hidden" name="userID" value="<%= userID %>">
        <input type="hidden" name="storeID" value="<%= storeID %>">
        <div class="mb-3">
            <label for="reviewText" class="form-label">리뷰 내용</label>
            <textarea class="form-control" id="reviewText" name="ReviewText" rows="5" required></textarea>
        </div>
        <div class="mb-3">
            <label for="reviewImage" class="form-label">이미지 추가</label>
            <input class="form-control" type="file" id="reviewImage" name="reviewImage">
        </div>
        <button type="submit" class="btn btn-primary">작성</button>
        <a href="reviewList.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
