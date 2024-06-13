<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Header</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $.ajax({
                url: 'checkLogin',
                method: 'GET',
                success: function(response) {
                    console.log("Login check response:", response);
                    if (response.trim() === 'storeLoggedIn') {
                        $('#navItems').html(`
                            <li class="nav-item"><a href="./viewReservations.jsp" class="nav-link">예약 현황</a></li>
                            <li class="nav-item"><a href="./businessPage.jsp" class="nav-link">마이페이지</a></li>
                            <a href="storeLogout.jsp" class="btn btn-sm btn-success">로그아웃</a>
                        `);
                    } else if (response.trim() === 'userLoggedIn') {
                        $('#navItems').html(`
                            <li class="nav-item"><a href="./stores.jsp" class="nav-link">가게 목록</a></li>
                            <li class="nav-item"><a href="./mypage.jsp" class="nav-link">마이페이지</a></li>
                            <a href="logout.jsp" class="btn btn-sm btn-success">로그아웃</a>
                        `);
                    } else {
                        $('#navItems').html(`
                            <li class="nav-item"><a href="./stores.jsp" class="nav-link">가게 목록</a></li>
                            <a href="StartPage.jsp" class="btn btn-sm btn-primary">로그인</a>
                        `);
                    }
                },
                error: function() {
                    console.log("Error in AJAX request.");
                    $('#navItems').html(`
                        <li class="nav-item"><a href="./stores.jsp" class="nav-link">가게 목록</a></li>
                        <a href="StartPage.jsp" class="btn btn-sm btn-primary">로그인</a>
                    `);
                }
            });
        });
    </script>
</head>
<body>
    <header class="pb-3 mb-4 border-bottom">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <a href="./welcome.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                    <svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path d="M8.707 1.5a1 1 0 0 1 1.414 0L14.646 6.146a5.5 5.5 0 0 1 .708.708L8 0.5 1.146 6.146a5.5 5.5 0 0 1 .708-.708L8 0.5l7.293 7.293a5.5 5.5 0 0 1-.708-.708L8 0.5z"/>
                        <path d="m8 3.293 6.071 6.071a1 1 0 0 1 .293.707v5.293h1.5a1 1 0 0 1 1 1v1H0v-1a1 1 0 0 1 1-1h1.5V10a1 1 0 0 1 .293-.707L8 3.293z"/>
                    </svg>
                    <span class="fs-4">Home</span>
                </a>
                <ul class="nav nav-pills" id="navItems">
                    <!-- Navigation items will be injected here based on login status -->
                </ul>
            </div>
        </div>
    </header>
</body>
</html>
