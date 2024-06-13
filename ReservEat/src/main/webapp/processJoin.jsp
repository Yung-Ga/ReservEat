<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.ConsumerDTO" %>
<%@ page import="dao.ConsumerDAO" %>
<%@ include file="dbconn.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        try {
            String UserID = request.getParameter("UserID");
            String Password = request.getParameter("Password");
            String UserName = request.getParameter("UserName");
            String Gender = request.getParameter("Gender");
            String BirthYY = request.getParameter("BirthYY");
            String BirthMM = request.getParameter("BirthMM");
            String BirthDD = request.getParameter("BirthDD");
            String Email = request.getParameter("mail1") + "@" + request.getParameter("mail2");
            String PhoneNumber = request.getParameter("PhoneNumber");
            String Address = request.getParameter("Address");

            // 디버깅 로그 추가
            System.out.println("Received UserID: " + UserID);
            System.out.println("Received Password: " + Password);
            System.out.println("Received UserName: " + UserName);
            System.out.println("Received Gender: " + Gender);
            System.out.println("Received BirthYY: " + BirthYY);
            System.out.println("Received BirthMM: " + BirthMM);
            System.out.println("Received BirthDD: " + BirthDD);
            System.out.println("Received Email: " + Email);
            System.out.println("Received PhoneNumber: " + PhoneNumber);
            System.out.println("Received Address: " + Address);

            // ConsumerDAO 객체 생성
            ConsumerDAO dao = new ConsumerDAO(conn); // conn은 DBconnect.jsp에서 제공
            ConsumerDTO existingConsumer = dao.getConsumerById(UserID);

            if (existingConsumer != null) {
                // 중복된 ID가 있는 경우
                response.sendRedirect("joinError.jsp?error=id_duplicate");
            } else {
                // 폼에서 받은 데이터
                ConsumerDTO consumer = new ConsumerDTO();
                consumer.setUserID(UserID);
                consumer.setPassword(Password);
                consumer.setUserName(UserName);
                consumer.setGender(Gender);
                consumer.setBirthYY(BirthYY != null && !BirthYY.isEmpty() ? BirthYY : "0");
                consumer.setBirthMM(BirthMM != null && !BirthMM.isEmpty() ? BirthMM : "0");
                consumer.setBirthDD(BirthDD != null && !BirthDD.isEmpty() ? BirthDD : "0");
                consumer.setEmail(Email);
                consumer.setPhoneNumber(PhoneNumber);
                consumer.setAddress(Address);

                System.out.println("Consumer Data: " + consumer); // 디버깅 로그 추가

                boolean isSuccess = dao.addConsumer(consumer);

                if (isSuccess) {
                    response.sendRedirect("joinSuccess.jsp");
                } else {
                    out.println("회원 가입에 실패했습니다. 다시 시도해주세요.");
                    response.sendRedirect("joinFail.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("오류가 발생하였습니다: " + e.getMessage());
        }
    } else {
        response.sendRedirect("joinForm.jsp");
    }
%>
