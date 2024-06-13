<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    String registrationNumber = request.getParameter("registrationNumber");
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT COUNT(*) FROM Store WHERE RegistrationNumber = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, registrationNumber);
        rs = pstmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.print("사업자 등록 번호가 중복되었습니다.");
        } else {
            out.print("사용 가능한 사업자 등록 번호입니다.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
