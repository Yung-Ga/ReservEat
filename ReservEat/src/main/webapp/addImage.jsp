<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 파일 저장 경로 설정
    String realFolder = "C:\\Users\\user\\eclipse-workspace_webServer\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ReservEat\\resources\\images";
    int maxSize = 5 * 1024 * 1024; // 최대 업로드될 파일의 크기 5MB
    String encType = "UTF-8"; // 인코딩 유형
    
    // 파일 업로드를 처리하는 MultipartRequest 객체 생성
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,  new DefaultFileRenamePolicy());

    // 폼 데이터 가져오기
    String storeID = multi.getParameter("storeID");
    String imageType = multi.getParameter("ImageType");
    String originalFileName = multi.getFilesystemName("Image");
    
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // 새 파일명 설정
        String newFileName = storeID + "_" + originalFileName;
        File oldFile = new File(realFolder + "\\" + originalFileName);
        File newFile = new File(realFolder + "\\" + newFileName);
        oldFile.renameTo(newFile);
        
        // Image 테이블에 데이터 삽입
        String insertImageSQL = "INSERT INTO Image (StoreID, ImageType, ImageURL) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(insertImageSQL);
        pstmt.setInt(1, Integer.parseInt(storeID));
        pstmt.setString(2, imageType);
        pstmt.setString(3, newFileName);
        pstmt.executeUpdate();
        
        // 디버깅 로그 출력
        System.out.println("storeID = " + storeID);
        System.out.println("imageType = " + imageType);
        System.out.println("originalFileName = " + originalFileName);
        
        response.sendRedirect("businessPage.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
