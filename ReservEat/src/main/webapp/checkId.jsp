<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
    String UserID = request.getParameter("id"); // AJAX 요청에서 'id' 파라미터 사용
    boolean isDuplicate = false;

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // SQL 쿼리 준비
        String sql = "SELECT UserID FROM User WHERE UserID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, UserID);
        System.out.println("Query executed: " + pstmt); // 디버깅 로그 추가
        rs = pstmt.executeQuery();

        // 결과 처리
        if (rs.next()) {
            isDuplicate = true;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.print("error");
        return;
    } finally {
        // 리소스 정리
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    // 결과 출력
    if (isDuplicate) {
        out.print("true"); // 중복된 경우 "true" 반환
    } else {
        out.print("false"); // 중복되지 않은 경우 "false" 반환
    }

    out.flush(); // 응답을 클라이언트로 보냅니다.
%>
