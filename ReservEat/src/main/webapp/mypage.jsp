<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>소비자 마이페이지</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <style>
        .btn-gray {
            background-color: gray;
            color: white;
            border: none;
            margin-bottom: 15px; /* 버튼 간의 간격 조절 */
        }
    </style>
</head>
<body>
<%
    String userId = (String) session.getAttribute("userID");
    String userEmail = (String) session.getAttribute("email");
    String userPhone = (String) session.getAttribute("phoneNumber");
    String userAddress = (String) session.getAttribute("address");
    String userName = (String) session.getAttribute("userName");
    String userGender = (String) session.getAttribute("gender");
    String userBirthYY = (String) session.getAttribute("birthYY");
    String userBirthMM = (String) session.getAttribute("birthMM");
    String userBirthDD = (String) session.getAttribute("birthDD");

    // 세션 값 출력 (디버깅용)
    System.out.println("UserID: " + userId);
    System.out.println("Email: " + userEmail);
    System.out.println("PhoneNumber: " + userPhone);
    System.out.println("Address: " + userAddress);
    System.out.println("UserName: " + userName);
    System.out.println("Gender: " + userGender);
    System.out.println("BirthYY: " + userBirthYY);
    System.out.println("BirthMM: " + userBirthMM);
    System.out.println("BirthDD: " + userBirthDD);

    if (userId != null) {
%>
<%@ include file="menu.jsp" %>
<div class="container py-4 text-center">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">마이페이지</h1>
            <p class="col-md-8 fs-4 mx-auto"><%= userName %>님 안녕하세요</p>
        </div>
    </div>
    <div class="card mx-auto" style="max-width: 600px;">
        <div class="card-body text-center">
            <p class="card-text"><strong>이름 :</strong> <%= userName %></p>
            <p class="card-text"><strong>이메일:</strong> <%= userEmail %></p>
            <p class="card-text"><strong>전화번호:</strong> <%= userPhone %></p>
            <p class="card-text"><strong>주소:</strong> <%= userAddress %></p>
            <p class="card-text"><strong>성별:</strong> <%= userGender %></p>
            <p class="card-text"><strong>생년월일:</strong> <%= userBirthYY %>-<%= userBirthMM %>-<%= userBirthDD %></p>
            <div class="text-center">
                <input type="button" value="개인정보 수정" class="btn btn-gray" onclick="location.href='modifyInfo.jsp'">
                <input type="button" value="예약 확인" class="btn btn-gray" onclick="location.href='UserReservationStatus.jsp'">
                <input type="button" value="리뷰관리" class="btn btn-gray" onclick="location.href='reviews.jsp'">
                <form action="deleteMember.jsp" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');" style="display:inline;">
                    <button type="submit" class="btn btn-gray">회원탈퇴</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
</body>
</html>
