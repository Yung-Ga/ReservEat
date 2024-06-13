<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    String realFolder = "C:\\Users\\user\\eclipse-workspace_webServer\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ReservEat\\resources\\images";
    int maxSize = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB
    String encType = "UTF-8"; // 인코딩 유형

    // 파일 업로드를 처리하는 MultipartRequest 객체 생성
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 폼 데이터 가져오기
    String storeID = multi.getParameter("StoreID");
    String password = multi.getParameter("Password");
    String phoneNumber = multi.getParameter("PhoneNumber");
    String ownerName = multi.getParameter("OwnerName");
    String districtID = multi.getParameter("DistrictID");
    String storeAddress = multi.getParameter("StoreAddress");
    String storeNumber = multi.getParameter("StoreNumber");
    String openTime = multi.getParameter("OpenTime");
    String closeTime = multi.getParameter("CloseTime");
    String closedDay = multi.getParameter("ClosedDay");
    String category = multi.getParameter("Category");
    String[] serviceTypes = multi.getParameterValues("ServiceType");
    String[] paymentMethods = multi.getParameterValues("PaymentMethods");

    // 서비스 유형과 결제 방법을 콤마로 구분하여 문자열로 변환
    String serviceType = serviceTypes != null ? String.join(", ", serviceTypes) : "";
    String paymentMethod = paymentMethods != null ? String.join(", ", paymentMethods) : "";

    // 전화번호 유효성 검사 (숫자와 하이픈만 허용)
    String phoneNumberPattern = "^[0-9-]+$";
    if (!phoneNumber.matches(phoneNumberPattern) || (storeNumber != null && !storeNumber.matches(phoneNumberPattern))) {
        out.println("<script>alert('전화번호는 숫자와 하이픈(-)만 입력 가능합니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE Store SET Password = ?, PhoneNumber = ?, OwnerName = ?, DistrictID = ?, StoreAddress = ?, StoreNumber = ?, Category = ?, OpenTime = ?, CloseTime = ?, ClosedDay = ?, ServiceType = ?, PaymentMethods = ? WHERE StoreID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, password);
        pstmt.setString(2, phoneNumber);
        pstmt.setString(3, ownerName);
        pstmt.setInt(4, Integer.parseInt(districtID));
        pstmt.setString(5, storeAddress);
        pstmt.setString(6, storeNumber);
        pstmt.setString(7, category);
        pstmt.setString(8, openTime);
        pstmt.setString(9, closeTime);
        pstmt.setString(10, closedDay);
        pstmt.setString(11, serviceType);
        pstmt.setString(12, paymentMethod);
        pstmt.setInt(13, Integer.parseInt(storeID));
        pstmt.executeUpdate();

        // 파일 업로드 처리
        String originalFileName = multi.getFilesystemName("photo");
        if (originalFileName != null) {
            // 새 파일명 설정
            String newFileName = storeID + "_" + originalFileName;
            File oldFile = new File(realFolder + "\\" + originalFileName);
            File newFile = new File(realFolder + "\\" + newFileName);
            oldFile.renameTo(newFile);

            // Store 테이블의 mainImage 업데이트
            String updateImageSQL = "UPDATE Store SET MainImage = ? WHERE StoreID = ?";
            pstmt = conn.prepareStatement(updateImageSQL);
            pstmt.setString(1, newFileName);
            pstmt.setInt(2, Integer.parseInt(storeID));
            pstmt.executeUpdate();
        }

        response.sendRedirect("businessPage.jsp?storeID=" + storeID);
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
