package com.vo;

import com.entity.ApplyData;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by admin on 2018/1/25.
 */
public class ApplyDataVO {
    private Integer id;
    private String username;
    private String startYear;
    private String endYear;
    private String dataType;
    private String coordinate;
    private String status;
    private Timestamp createTime;
    private Timestamp updateTime;

    public ApplyDataVO(){
        super();
    }

    public ApplyDataVO(ApplyData applyData){
        this.id = applyData.getId();
        this.startYear = applyData.getStartTime();
        this.endYear = applyData.getEndTime();
        this.dataType = applyData.getDataType();
        this.status = applyData.getStatus();
        this.createTime = applyData.getCreateTime();
        this.updateTime = applyData.getUpdateTime();
    }

    public String getUsername() {
        return username;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }
}
