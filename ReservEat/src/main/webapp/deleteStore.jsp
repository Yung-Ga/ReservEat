<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String storeID = request.getParameter("storeID");

    if (storeID == null || storeID.isEmpty()) {
        out.println("<script>alert('가게 ID가 제공되지 않았습니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 가게 이미지 파일 경로 가져오기
        String getImageSQL = "SELECT ImageURL FROM Image WHERE StoreID = ?";
        pstmt = conn.prepareStatement(getImageSQL);
        pstmt.setInt(1, Integer.parseInt(storeID));
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String imageURL = rs.getString("ImageURL");
            File imageFile = new File("C:\\Users\\user\\eclipse-workspace_webServer\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ReservEat\\resources\\images\\" + imageURL);
            if (imageFile.exists()) {
                imageFile.delete();
            }
        }
        rs.close();
        pstmt.close();

        // 이미지 테이블에서 가게 이미지 삭제
        String deleteImageSQL = "DELETE FROM Image WHERE StoreID = ?";
        pstmt = conn.prepareStatement(deleteImageSQL);
        pstmt.setInt(1, Integer.parseInt(storeID));
        pstmt.executeUpdate();
        pstmt.close();

        // 가게 테이블에서 가게 정보 삭제
        String deleteStoreSQL = "DELETE FROM Store WHERE StoreID = ?";
        pstmt = conn.prepareStatement(deleteStoreSQL);
        pstmt.setInt(1, Integer.parseInt(storeID));
        pstmt.executeUpdate();
        pstmt.close();

        // 로그아웃 처리
        session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }

        response.sendRedirect("StartPage.jsp"); // 로그아웃 후 시작 페이지로 리디렉션
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
