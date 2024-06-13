<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<%
    // 세션에서 사용자 ID를 가져옴
    String UserID = (String) session.getAttribute("UserID");

    if (UserID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/reserveatdb", "root", "0806");

        // SQL 쿼리 작성
        String sql = "DELETE FROM consumers WHERE UserID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, UserID);

        // 쿼리 실행
        int rowsDeleted = pstmt.executeUpdate();

        // 삭제 성공 시 세션 무효화 및 로그아웃 처리
        if (rowsDeleted > 0) {
            session.invalidate();
            response.sendRedirect("logout.jsp");
        } else {
            out.println("회원 삭제에 실패했습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("회원 삭제 중 오류가 발생했습니다.");
        out.println("<pre>" + e.getMessage() + "</pre>");
    } finally {
        // 리소스 정리
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
