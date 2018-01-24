package com.entity;

/**
 * Created by admin on 2017/10/17.
 */
public class QueryData {
    private String longitude;
    private String latitude;
    private String[] weather;
    private String soil;
    private String[] vegetation;
    private String[] terrain;
    private String[] carbon;
    private String startYear;
    private String endYear;

    public QueryData(String longitude, String latitude, String[] weather, String soil, String[] vegetation, String[] terrain, String[] carbon, String startYear, String endYear) {
        this.longitude = longitude;
        this.latitude = latitude;
        this.weather = weather;
        this.soil = soil;
        this.vegetation = vegetation;
        this.terrain = terrain;
        this.carbon = carbon;
        this.startYear = startYear;
        this.endYear = endYear;
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

    public String[] getWeather() {
        return weather;
    }

    public void setWeather(String[] weather) {
        this.weather = weather;
    }

    public String getSoil() {
        return soil;
    }

    public void setSoil(String soil) {
        this.soil = soil;
    }

    public String[] getVegetation() {
        return vegetation;
    }

    public void setVegetation(String[] vegetation) {
        this.vegetation = vegetation;
    }

    public String[] getTerrain() {
        return terrain;
    }

    public void setTerrain(String[] terrain) {
        this.terrain = terrain;
    }

    public String[] getCarbon() {
        return carbon;
    }

    public void setCarbon(String[] carbon) {
        this.carbon = carbon;
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
}
