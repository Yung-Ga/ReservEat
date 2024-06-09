<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<%
    String id = request.getParameter("id");

    if (id != null && !id.isEmpty()) {
        conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = (Connection) pageContext.getAttribute("conn", PageContext.REQUEST_SCOPE);

            String sql = "DELETE FROM consumers WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("listMembers.jsp");
            } else {
                out.println("<h1>회원 삭제에 실패했습니다.</h1>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h1>회원 삭제 중 오류가 발생했습니다.</h1>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        out.println("<h1>잘못된 요청입니다.</h1>");
    }
%>

