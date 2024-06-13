function checkAddStore() {
    var registrationNumber = document.getElementById("RegistrationNumber");
    var password = document.getElementById("Password");
    var phoneNumber = document.getElementById("PhoneNumber");
    var storeName = document.getElementById("StoreName");
    var ownerName = document.getElementById("OwnerName");
    var storeAddress = document.getElementById("StoreAddress");
    var storeNumber = document.getElementById("StoreNumber");
    var openTime = document.getElementById("OpenTime");
    var closeTime = document.getElementById("CloseTime");
    var closedDay = document.getElementById("ClosedDay");

    // 등록 번호 체크
    if (!check(/^[0-9]{4,11}$/, registrationNumber, "[등록 번호]\n숫자를 조합하여 5~14자까지 입력\n"))
        return false;

    // 비밀번호 체크
    if (password.value.length < 4 || password.value.length > 20) {
        alert("[비밀번호]\n최소 4자에서 최대 20자까지 입력");
        password.focus();
        return false;
    }

    // 전화번호 체크
    if (!check(/^\d{2,3}-\d{3,4}-\d{4}$/, phoneNumber, "[전화번호]\n올바른 형식으로 입력 (예: 010-1234-5678)"))
        return false;

    // 가게 이름 체크
    if (storeName.value.length < 2 || storeName.value.length > 50) {
        alert("[가게 이름]\n최소 2자에서 최대 50자까지 입력");
        storeName.focus();
        return false;
    }

    // 소유자 이름 체크
    if (ownerName.value.length < 2 || ownerName.value.length > 50) {
        alert("[대표자 이름]\n최소 2자에서 최대 50자까지 입력");
        ownerName.focus();
        return false;
    }

    // 가게 주소 체크
    if (storeAddress.value.length < 5) {
        alert("[가게 주소]\n최소 5자 이상 입력");
        storeAddress.focus();
        return false;
    }

    // 가게 번호 체크
    if (!check(/^\d{2,4}-\d{3,4}-\d{4}$/, phoneNumber, "[가게 번호]\n올바른 형식으로 입력 (예: 20-1234-5678)"))
        return false;

    // 영업 시간 체크
    if (!check(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, openTime, "[영업 시작 시간]\n올바른 시간 형식으로 입력 (예: 09:00)"))
        return false;
    if (!check(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, closeTime, "[영업 종료 시간]\n올바른 시간 형식으로 입력 (예: 18:00)"))
        return false;

    // 휴무일 체크
    if (closedDay.value.length < 2 || closedDay.value.length > 20) {
        alert("[휴무일]\n최소 2자에서 최대 20자까지 입력");
        closedDay.focus();
        return false;
    }

    function check(regExp, e, msg) {
        if (regExp.test(e.value)) {
            return true;
        }
        alert(msg);
        e.focus();
        return false;
    }

    document.newStore.submit();
}
