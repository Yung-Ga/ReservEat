<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/ReservEatDB";
    String user = "root";
    String password = "1234";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        pageContext.setAttribute("conn", conn, PageContext.REQUEST_SCOPE);
        out.println("데이터베이스 연결에 성공했습니다."); // 디버깅 정보 출력
    } catch (Exception e) {
        e.printStackTrace();
        throw new ServletException("데이터베이스 연결에 실패했습니다. " + e.getMessage());
    }
%>
