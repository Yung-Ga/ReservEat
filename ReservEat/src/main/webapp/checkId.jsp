<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<%
    String id = request.getParameter("id");
    boolean isDuplicate = false;
    String errorMessage = null;

    try {
        if (id != null && !id.isEmpty()) {
         	conn = (Connection) pageContext.getAttribute("conn", PageContext.REQUEST_SCOPE);
            if (conn != null) {
                String sql = "SELECT id FROM consumers WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, id);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    isDuplicate = true;
                }
                rs.close();
                pstmt.close();
                conn.close();
            } else {
                errorMessage = "데이터베이스 연결에 실패했습니다.";
            }
        } else {
            errorMessage = "아이디가 유효하지 않습니다.";
        }
    } catch (SQLException e) {
        e.printStackTrace();
        errorMessage = "SQL 예외가 발생했습니다: " + e.getMessage();
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (errorMessage != null) {
        out.print("{\"error\": \"" + errorMessage + "\"}");
    } else {
        out.print("{\"isDuplicate\": " + isDuplicate + "}");
    }
    out.flush();
%>

