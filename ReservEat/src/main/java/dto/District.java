package dto;

public class District {
    private int districtID;
    private String districtName;

    public District(int districtID, String districtName) {
        this.districtID = districtID;
        this.districtName = districtName;
    }

    public int getDistrictID() {
        return districtID;
    }

    public String getDistrictName() {
        return districtName;
    }
}