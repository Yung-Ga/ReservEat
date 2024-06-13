<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>

<script>
    function redirectToPage(type) {
        window.location.href = './stores.jsp?type=' + type;
    }
</script>

<html>
<head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
<title>Welcome</title>
<style>
.btn-custom-container {
    display: inline-block;
    text-align: center;
    margin-right: 40px;
    margin-bottom: 20px;
}

.btn-custom {
    width: 90px;
    height: 90px;
    border: none;
    background: none;
    padding: 0;
    cursor: pointer;
}

.btn-custom img {
    width: 100%;
    height: 100%;
}
</style>
</head>
<body>
    <div class="container py-4">
        <%@ include file="menu.jsp"%>
        <%!String greeting = "Welcome to ReservEat!";
        String tagline = "Welcome to ReservEat!";%>
        <div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold"><%=greeting%></h1>
                <p class="col-md-8 fs-4">ReservEat</p>
            </div>
        </div>

        <div class="row align-items-md-stretch text-center">
            <div class="col-md-12">
                <div class="h-100 p-5">
                    <div class="mb-3">
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Korean')">
                                <img src="./resources/images/bibimbap.png" alt="Icon 1">
                            </button>
                            <div>한식</div>
                        </div>
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Western')">
                                <img src="./resources/images/dish.png" alt="Icon 2">
                            </button>
                            <div>양식</div>
                        </div>
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Japanese')">
                                <img src="./resources/images/sushi.png" alt="Icon 3">
                            </button>
                            <div>일식</div>
                        </div>
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Chinese')">
                                <img src="./resources/images/buns.png" alt="Icon 4">
                            </button>
                            <div>중식</div>
                        </div>
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Asian')">
                                <img src="./resources/images/padthai.png" alt="Icon 5">
                            </button>
                            <div>아시안</div>
                        </div>
                        <div class="btn-custom-container">
                            <button type="button" class="btn-custom" onclick="redirectToPage('Cafe')">
                                <img src="./resources/images/coffee.png" alt="Icon 6">
                            </button>
                            <div>카페</div>
                        </div>
                    </div>

                    <h3><%=tagline%></h3>
                    <%
                    response.setIntHeader("Refresh", 5);
                    Date day = new java.util.Date();
                    String am_pm;
                    int hour = day.getHours();
                    int minute = day.getMinutes();
                    int second = day.getSeconds();
                    if (hour / 12 == 0) {
                        am_pm = "AM";
                    } else {
                        am_pm = "PM";
                        hour -= 12;
                    }
                    String CT = hour + ":" + minute + ":" + second + " " + am_pm;
                    out.println("현재 접속 시각: " + CT + "\n");
                    %>
                </div>
            </div>
        </div>
        <%@ include file="footer.jsp"%>
    </div>
</body>
</html>
