<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 가져오기
    String userID = request.getParameter("userID");
    String userName = request.getParameter("userName");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String address = request.getParameter("address");
    String gender = request.getParameter("gender");
    String birthYY = request.getParameter("birthYY");
    String birthMM = request.getParameter("birthMM");
    String birthDD = request.getParameter("birthDD");

    // 디버깅 출력
    System.out.println("userID: " + userID);
    System.out.println("userName: " + userName);
    System.out.println("email: " + email);
    System.out.println("phoneNumber: " + phoneNumber);
    System.out.println("address: " + address);
    System.out.println("gender: " + gender);
    System.out.println("birthYY: " + birthYY);
    System.out.println("birthMM: " + birthMM);
    System.out.println("birthDD: " + birthDD);

    // null 체크
    if (userID == null || userName == null || email == null || phoneNumber == null || address == null || gender == null || birthYY == null || birthMM == null || birthDD == null) {
        out.println("<script>alert('모든 필드를 입력해주세요.'); history.back();</script>");
        return;
    }

    // 전화번호 유효성 검사 (숫자와 하이픈만 허용)
    String phoneNumberPattern = "^[0-9-]+$";
    if (!phoneNumber.matches(phoneNumberPattern)) {
        out.println("<script>alert('전화번호는 숫자와 하이픈(-)만 입력 가능합니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE User SET UserName = ?, Email = ?, PhoneNumber = ?, Address = ?, Gender = ?, BirthYY = ?, BirthMM = ?, BirthDD = ? WHERE UserID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userName);
        pstmt.setString(2, email);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, address);
        pstmt.setString(5, gender);
        pstmt.setString(6, birthYY);
        pstmt.setString(7, birthMM);
        pstmt.setString(8, birthDD);
        pstmt.setString(9, userID);
        pstmt.executeUpdate();

        // 세션 업데이트
        session.setAttribute("userName", userName);
        session.setAttribute("email", email);
        session.setAttribute("phoneNumber", phoneNumber);
        session.setAttribute("address", address);
        session.setAttribute("gender", gender);
        session.setAttribute("birthYY", birthYY);
        session.setAttribute("birthMM", birthMM);
        session.setAttribute("birthDD", birthDD);

        response.sendRedirect("mypage.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
