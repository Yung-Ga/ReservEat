<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>개인정보 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
</head>
<body>
<%
    String userId = (String) session.getAttribute("userID");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userEmail = (String) session.getAttribute("email");
    String userPhone = (String) session.getAttribute("phoneNumber");
    String userAddress = (String) session.getAttribute("address");
    String userName = (String) session.getAttribute("userName");
    String userGender = (String) session.getAttribute("gender");
    String userBirthYY = (String) session.getAttribute("birthYY");
    String userBirthMM = (String) session.getAttribute("birthMM");
    String userBirthDD = (String) session.getAttribute("birthDD");
%>
<div class="container py-4 text-center">
    <%@ include file="menu.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">개인정보 수정</h1>
            <p class="col-md-8 fs-4 mx-auto">Personal Information Edit</p>
        </div>
    </div>
    
    <div class="card mx-auto" style="max-width: 600px;">
        <div class="card-body text-center">
            <form name="editProfile" action="processModify.jsp" method="post">
                <input type="hidden" name="userID" value="<%= userId %>" />
                
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">이름</label>
                    <div class="col-sm-8">
                        <input type="text" id="userName" name="userName" class="form-control" value="<%= userName %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">이메일</label>
                    <div class="col-sm-8">
                        <input type="email" id="email" name="email" class="form-control" value="<%= userEmail %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">전화번호</label>
                    <div class="col-sm-8">
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= userPhone %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">주소</label>
                    <div class="col-sm-8">
                        <input type="text" id="address" name="address" class="form-control" value="<%= userAddress %>" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">성별</label>
                    <div class="col-sm-8">
                        <select id="gender" name="gender" class="form-select" required>
                            <option value="M" <%= "M".equals(userGender) ? "selected" : "" %>>남</option>
                            <option value="F" <%= "F".equals(userGender) ? "selected" : "" %>>여</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label">생년월일</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input type="text" id="birthYY" name="birthYY" class="form-control" maxlength="4" placeholder="년(4자)" value="<%= userBirthYY %>" required>
                            <select id="birthMM" name="birthMM" class="form-select" required>
                                <option value="1" <%= "1".equals(userBirthMM) ? "selected" : "" %>>1</option>
                                <option value="2" <%= "2".equals(userBirthMM) ? "selected" : "" %>>2</option>
                                <option value="3" <%= "3".equals(userBirthMM) ? "selected" : "" %>>3</option>
                                <option value="4" <%= "4".equals(userBirthMM) ? "selected" : "" %>>4</option>
                                <option value="5" <%= "5".equals(userBirthMM) ? "selected" : "" %>>5</option>
                                <option value="6" <%= "6".equals(userBirthMM) ? "selected" : "" %>>6</option>
                                <option value="7" <%= "7".equals(userBirthMM) ? "selected" : "" %>>7</option>
                                <option value="8" <%= "8".equals(userBirthMM) ? "selected" : "" %>>8</option>
                                <option value="9" <%= "9".equals(userBirthMM) ? "selected" : "" %>>9</option>
                                <option value="10" <%= "10".equals(userBirthMM) ? "selected" : "" %>>10</option>
                                <option value="11" <%= "11".equals(userBirthMM) ? "selected" : "" %>>11</option>
                                <option value="12" <%= "12".equals(userBirthMM) ? "selected" : "" %>>12</option>
                            </select>
                            <input type="text" id="birthDD" name="birthDD" class="form-control" maxlength="2" placeholder="일" value="<%= userBirthDD %>" required>
                        </div>
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-primary">수정</button>
                        <a href="mypage.jsp" class="btn btn-secondary">취소</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
