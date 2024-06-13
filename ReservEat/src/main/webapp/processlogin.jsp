<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ include file="dbconn.jsp" %>
<%
    String username = request.getParameter("UserID");
    String password = request.getParameter("Password");

    boolean isValid = false;

    // 디버깅을 위한 로그 메시지 추가
    System.out.println("Debug: 입력된 UserID = " + username);
    System.out.println("Debug: 입력된 Password = " + password);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("Debug: 데이터베이스 연결 성공");

        String sql = "SELECT * FROM User WHERE UserID = ? AND Password = ?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);
        
        System.out.println("Debug: 실행할 쿼리 = " + statement.toString());

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            isValid = true;
            System.out.println("Debug: 유효한 사용자입니다.");
        } else {
            System.out.println("Debug: 유효하지 않은 사용자입니다.");
        }

        resultSet.close();
        statement.close();
        conn.close();
        System.out.println("Debug: 데이터베이스 연결 종료");

    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Debug: 예외 발생 - " + e.getMessage());
    }

    if (isValid) {
        session.setAttribute("username", username);
        System.out.println("Debug: 로그인 성공, welcome.jsp로 리디렉션");
        response.sendRedirect("welcome.jsp");
    } else {
        System.out.println("Debug: 로그인 실패, login.jsp로 리디렉션");
        response.sendRedirect("login.jsp?error=true");
    }
%>
