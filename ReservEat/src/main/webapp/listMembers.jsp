<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 목록</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
</head>
<body>
    <div class="container py-4">
        <h1 class="mb-4">회원 목록</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                    <!-- 작업 열 추가 -->
                </tr>
            </thead>
            <tbody>
                <%
                    conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = (Connection) pageContext.getAttribute("conn", PageContext.REQUEST_SCOPE);

                        String sql = "SELECT id, name, phonenumber, email FROM consumers";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String id = rs.getString("id");
                            String name = rs.getString("name");
                            String phonenumber = rs.getString("phonenumber");
                            String email = rs.getString("email");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= phonenumber %></td>
                    <td><%= email %></td>
                    <td>
                        <form action="deleteMember.jsp" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='5'>회원 정보를 가져오는 중 오류가 발생했습니다.</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

