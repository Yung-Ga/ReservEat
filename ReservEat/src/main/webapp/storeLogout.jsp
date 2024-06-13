<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 세션을 무효화하여 로그아웃 처리
    if (session != null) {
        session.invalidate(); // 세션 무효화
    }

    response.sendRedirect("welcome.jsp");
%>
