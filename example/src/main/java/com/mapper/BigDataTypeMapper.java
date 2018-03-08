package com.mapper;

import com.entity.BigDataType;
import com.entity.User;

import java.util.List;

/**
 * Created by admin on 2017/10/16.
 */
public interface BigDataTypeMapper {

    List<BigDataType> acquiredAllBigDataType();

    void saveBigDataType(BigDataType bigDataType);

    BigDataType getBigDataTypeByName(String dataTypeEnglish);
}
