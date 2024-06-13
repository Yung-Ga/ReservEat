<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="DBconnect.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원 목록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
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
                    <th>비밀번호</th> <!-- 비밀번호 열 추가 -->
                    <th>작업</th> <!-- 작업 열 추가 -->
                </tr>
            </thead>
            <tbody>
                <%
                    conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Reserveatdb", "root", "1234");

                        String sql = "SELECT id, name, phone, email, password FROM consumers"; // 비밀번호(pw)도 가져옴
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String id = rs.getString("id");
                            String name = rs.getString("name");
                            String phonenumber = rs.getString("phone");
                            String email = rs.getString("email");
                            String passwd = rs.getString("password"); // 비밀번호 가져오기
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= phonenumber %></td>
                    <td><%= email %></td>
                    <td><%= password %></td> <!-- 비밀번호 표시 -->
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
                        out.println("<tr><td colspan='6'>회원 정보를 가져오는 중 오류가 발생했습니다.</td></tr>");
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

