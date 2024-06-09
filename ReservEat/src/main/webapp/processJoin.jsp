<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        // 폼에서 받은 데이터
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String phone1 = request.getParameter("phone1");
        String phone2 = request.getParameter("phone2");
        String phone3 = request.getParameter("phone3");
        String email1 = request.getParameter("email1");
        String email2 = request.getParameter("email2");

        // 전화번호와 이메일 합치기
        String phone = phone1 + "-" + phone2 + "-" + phone3;
        String email = email1 + "@" + email2;

        PreparedStatement pstmt = null;
        String sql = "INSERT INTO consumers (id, pw, name, phonenumber, email) VALUES (?, ?, ?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            pstmt.setString(3, name);
            pstmt.setString(4, phone);
            pstmt.setString(5, email);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("joinSuccess.jsp");
            } else {
                response.sendRedirect("joinFail.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h1>회원 가입 중 오류가 발생했습니다.</h1>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        response.sendRedirect("joinForm.jsp");
    }
%>
