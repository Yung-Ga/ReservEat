<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
    // 세션에서 사용자 ID 가져오기
    String userID = (String) session.getAttribute("userID");

    // 요청 매개 변수 가져오기
    int storeID = Integer.parseInt(request.getParameter("storeID"));
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));

    // 디버그용 로그 출력
    System.out.println("Debug: userID = " + userID);
    System.out.println("Debug: storeID = " + storeID);
    System.out.println("Debug: date = " + date);
    System.out.println("Debug: time = " + time);
    System.out.println("Debug: numberOfPeople = " + numberOfPeople);

    if (userID == null) {
        out.println("<script>alert('로그인이 필요합니다.'); window.location.href='login.jsp';</script>");
        return;
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 사용자 ID가 User 테이블에 존재하는지 확인
        String checkUserSQL = "SELECT COUNT(*) FROM User WHERE UserID = ?";
        pstmt = conn.prepareStatement(checkUserSQL);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int userCount = rs.getInt(1);
            System.out.println("Debug: userCount = " + userCount); // 디버그용 로그 추가

            if (userCount > 0) {
                // 예약 업데이트
                String sql = "UPDATE Reservation SET UserID = ?, NumberOfPeople = ?, ReservationStatus = 'Confirmed' WHERE StoreID = ? AND ReservationDate = ? AND ReservationTime = ? AND UserID IS NULL";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userID);
                pstmt.setInt(2, numberOfPeople);
                pstmt.setInt(3, storeID);
                pstmt.setDate(4, Date.valueOf(date));
                pstmt.setTime(5, Time.valueOf(time));

                int updatedRows = pstmt.executeUpdate();
                System.out.println("Debug: updatedRows = " + updatedRows); // 디버그용 로그 추가

                if (updatedRows > 0) {
                    // 세션에 예약 정보 업데이트
                    session.setAttribute("StoreID", storeID);
                    session.setAttribute("reservationDate", date);
                    session.setAttribute("reservationTime", time);
                    session.setAttribute("numberOfPeople", numberOfPeople);
                    session.setAttribute("userName", (String) session.getAttribute("userName")); // 사용자 이름 세션에 추가
                    session.setAttribute("userPhoneNumber", (String) session.getAttribute("userPhoneNumber")); // 사용자 전화번호 세션에 추가

                    out.println("<script>alert('예약이 성공적으로 완료되었습니다.'); window.location.href='reservationSuccess.jsp';</script>");
                } else {
                    out.println("<script>alert('예약을 완료할 수 없습니다. 이미 예약된 시간입니다.'); history.back();</script>");
                }
            } else {
                out.println("<script>alert('유효한 사용자 ID가 아닙니다.'); history.back();</script>");
            }
        } else {
            out.println("<script>alert('유효한 사용자 ID가 아닙니다.'); history.back();</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
