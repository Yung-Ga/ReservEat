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
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 폼 데이터 가져오기
    String storeName = multi.getParameter("StoreName");
    String registrationNumber = multi.getParameter("RegistrationNumber");
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
    String imageType = multi.getParameter("ImageType");
    String originalFileName = multi.getFilesystemName("Image");

    // 서비스 유형과 결제 방법을 콤마로 구분하여 문자열로 변환
    String serviceType = serviceTypes != null ? String.join(", ", serviceTypes) : "";
    String paymentMethod = paymentMethods != null ? String.join(", ", paymentMethods) : "";

    // 필수 입력 필드 확인
    if (storeName == null || storeName.isEmpty() ||
        registrationNumber == null || registrationNumber.isEmpty() ||
        password == null || password.isEmpty() ||
        phoneNumber == null || phoneNumber.isEmpty() ||
        ownerName == null || ownerName.isEmpty() ||
        districtID == null || districtID.isEmpty() ||
        storeAddress == null || storeAddress.isEmpty() ||
        openTime == null || openTime.isEmpty() ||
        closeTime == null || closeTime.isEmpty() ||
        category == null || category.isEmpty()) {
        out.println("<script>alert('모든 항목을 입력해 주세요.'); history.back();</script>");
        return;
    }

    // 전화번호 유효성 검사 (숫자와 하이픈만 허용)
    String phoneNumberPattern = "^[0-9-]+$";
    if (!phoneNumber.matches(phoneNumberPattern) || (storeNumber != null && !storeNumber.matches(phoneNumberPattern))) {
        out.println("<script>alert('전화번호는 숫자와 하이픈(-)만 입력 가능합니다.'); history.back();</script>");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int storeID = 0;

    try {
        // 사업자 등록 번호 중복 검사
        String checkSQL = "SELECT COUNT(*) FROM Store WHERE RegistrationNumber = ?";
        pstmt = conn.prepareStatement(checkSQL);
        pstmt.setString(1, registrationNumber);
        rs = pstmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            out.println("<script>alert('사업자 등록 번호가 중복되었습니다.'); history.back();</script>");
        } else {
            // Store 테이블에 데이터 삽입
            String insertSQL = "INSERT INTO Store (RegistrationNumber, Password, PhoneNumber, StoreName, OwnerName, DistrictID, StoreAddress, StoreNumber, OpenTime, CloseTime, ClosedDay, Category, ServiceType, PaymentMethods) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, registrationNumber);
            pstmt.setString(2, password);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, storeName);
            pstmt.setString(5, ownerName);
            pstmt.setInt(6, Integer.parseInt(districtID));
            pstmt.setString(7, storeAddress);
            pstmt.setString(8, storeNumber);
            pstmt.setString(9, openTime);
            pstmt.setString(10, closeTime);
            pstmt.setString(11, closedDay);
            pstmt.setString(12, category);
            pstmt.setString(13, serviceType);
            pstmt.setString(14, paymentMethod);
            pstmt.executeUpdate();

            // StoreID 가져오기
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                storeID = rs.getInt(1);
            }

            if (originalFileName != null && !originalFileName.isEmpty()) {
                // 새 파일명 설정
                String newFileName = storeID + "_" + originalFileName;
                File oldFile = new File(realFolder + "\\" + originalFileName);
                File newFile = new File(realFolder + "\\" + newFileName);
                oldFile.renameTo(newFile);

                // Store 테이블의 mainImage 업데이트
                String updateStoreSQL = "UPDATE Store SET mainImage = ? WHERE StoreID = ?";
                pstmt = conn.prepareStatement(updateStoreSQL);
                pstmt.setString(1, newFileName);
                pstmt.setInt(2, storeID);
                pstmt.executeUpdate();

                // Image 테이블에 데이터 삽입
                String insertImageSQL = "INSERT INTO Image (StoreID, ImageType, ImageURL) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertImageSQL);
                pstmt.setInt(1, storeID);
                pstmt.setString(2, imageType);
                pstmt.setString(3, newFileName);
                pstmt.executeUpdate();
            }

            response.sendRedirect("storeLogInPage.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
