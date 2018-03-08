package com.vo;

import java.security.PrivateKey;

/**
 * Created by admin on 2018/3/7.
 */
public class DataTypeVo {
    private String latitude;
    private String longitude;
    private Integer startYear;
    private Integer endYear;
    private String bigDataTypeEnglish;
    private String smallDataTypeEnglish;

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public Integer getStartYear() {
        return startYear;
    }

    public void setStartYear(Integer startYear) {
        this.startYear = startYear;
    }

    public Integer getEndYear() {
        return endYear;
    }

    public void setEndYear(Integer endYear) {
        this.endYear = endYear;
    }

    public String getBigDataTypeEnglish() {
        return bigDataTypeEnglish;
    }

    public void setBigDataTypeEnglish(String bigDataTypeEnglish) {
        this.bigDataTypeEnglish = bigDataTypeEnglish;
    }

    public String getSmallDataTypeEnglish() {
        return smallDataTypeEnglish;
    }

    public void setSmallDataTypeEnglish(String smallDataTypeEnglish) {
        this.smallDataTypeEnglish = smallDataTypeEnglish;
    }
}
