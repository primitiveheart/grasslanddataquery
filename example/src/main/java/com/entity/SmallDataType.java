package com.entity;

import com.vo.SmallDataTypeVo;

/**
 * 小数据类型的类
 * Created by admin on 2018/3/3.
 */
public class SmallDataType {
    private Integer id;
    private String dataType;
    private String dataTypeEnglish;
    private Integer bigDataTypeId;

    public SmallDataType(){}

    public SmallDataType(SmallDataTypeVo smallDataTypeVo, BigDataType bigDataType){
        this.id = smallDataTypeVo.getId();
        this.dataType = smallDataTypeVo.getDataType();
        this.dataTypeEnglish = smallDataTypeVo.getDataTypeEnglish();
        this.bigDataTypeId = bigDataType.getId();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getDataTypeEnglish() {
        return dataTypeEnglish;
    }

    public void setDataTypeEnglish(String dataTypeEnglish) {
        this.dataTypeEnglish = dataTypeEnglish;
    }

    public Integer getBigDataTypeId() {
        return bigDataTypeId;
    }

    public void setBigDataTypeId(Integer bigDataTypeId) {
        this.bigDataTypeId = bigDataTypeId;
    }
}
