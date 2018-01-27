package com.mapper;

import com.entity.BigDataType;
import com.entity.ServiceData;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2017/10/16.
 */
public interface ServiceDataMapper {

    void addServiceData(ServiceData serviceData);

    Integer serviceDataTotal();

    void deleteServiceData(Integer id);

    void updateServiceData(ServiceData serviceData);

    List<ServiceData> queryServiceDataByBigAndSmallDataTypeBetweenYear(@Param("bigDataType") String bigDataType, @Param("smallDataType") String smallDataType,
                                                            @Param("startYear")Integer startYear, @Param("endYear")Integer endYear);

    List<ServiceData> acquiredServiceDataPageData(@Param("start") Integer start, @Param("length") Integer length);
}
