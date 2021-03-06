package com.entity;

import java.sql.Time;
import java.sql.Timestamp;

/**
 * Created by admin on 2018/1/26.
 */
public class ServiceData {
    private Integer id;
    private String bigDataType;
    private String smallDataType;
    private String workspace;
    private Integer year;
    private String layer;
    private Timestamp createTime;
    private Timestamp updateTime;

    public String getWorkspace() {
        return workspace;
    }

    public void setWorkspace(String workspace) {
        this.workspace = workspace;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBigDataType() {
        return bigDataType;
    }

    public void setBigDataType(String bigDataType) {
        this.bigDataType = bigDataType;
    }

    public String getSmallDataType() {
        return smallDataType;
    }

    public void setSmallDataType(String smallDataType) {
        this.smallDataType = smallDataType;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getLayer() {
        return layer;
    }

    public void setLayer(String layer) {
        this.layer = layer;
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
