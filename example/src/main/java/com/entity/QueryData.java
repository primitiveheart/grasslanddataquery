package com.entity;

/**
 * Created by admin on 2017/10/17.
 */
public class QueryData {
    private String longitude;
    private String latitude;
    private String pixelX;
    private String pixelY;
    private String startYear;
    private String endYear;

    public QueryData(String longitude, String latitude, String pixelX, String pixelY, String startYear, String endYear) {
        this.longitude = longitude;
        this.latitude = latitude;
        this.startYear = startYear;
        this.endYear = endYear;
        this.pixelX = pixelX;
        this.pixelY = pixelY;
    }

    public QueryData(){}

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getStartYear() {
        return startYear;
    }

    public void setStartYear(String startYear) {
        this.startYear = startYear;
    }

    public String getEndYear() {
        return endYear;
    }

    public void setEndYear(String endYear) {
        this.endYear = endYear;
    }

    public String getPixelX() {
        return pixelX;
    }

    public void setPixelX(String pixelX) {
        this.pixelX = pixelX;
    }

    public String getPixelY() {
        return pixelY;
    }

    public void setPixelY(String pixelY) {
        this.pixelY = pixelY;
    }
}
