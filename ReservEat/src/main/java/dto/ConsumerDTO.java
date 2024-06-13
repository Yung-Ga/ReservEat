package dto;

public class ConsumerDTO {
    private String UserID;
    private String UserName;
    private String Password;
    private String Gender;
    private String BirthYY;
    private String BirthMM;
    private String BirthDD;
    private String Email;
    private String PhoneNumber;
    private String Address;

    public ConsumerDTO() {
        super();
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getBirthYY() {
        return BirthYY;
    }

    public void setBirthYY(String BirthYY) {
        this.BirthYY = BirthYY;
    }

    public String getBirthMM() {
        return BirthMM;
    }

    public void setBirthMM(String BirthMM) {
        this.BirthMM = BirthMM;
    }

    public String getBirthDD() {
        return BirthDD;
    }

    public void setBirthDD(String BirthDD) {
        this.BirthDD = BirthDD;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }
}

