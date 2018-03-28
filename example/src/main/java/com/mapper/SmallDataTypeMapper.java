package com.mapper;

import com.entity.SmallDataType;
import com.vo.BigSmallDataTypeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2018/3/5.
 */
public interface SmallDataTypeMapper {
    void saveSmallDataType(SmallDataType smallDataType);

    /**
     * @param bigDataTypeId 大数据类型表的id
     * @return
     */
    List<SmallDataType> listAllSmallDataType(Integer bigDataTypeId);

    /**
     * 根据大数据类型和小数据类型得到大小数据类型
     * @param bigDataTypeEnglish
     * @param smallDataTypeEnglish
     * @return
     */
    BigSmallDataTypeVo getBigSmallDataType(@Param("bigDataTypeEnglish") String bigDataTypeEnglish, @Param("smallDataTypeEnglish") String smallDataTypeEnglish);

    /**
     * 得到所有的大小数据类型
     * @return
     */
    List<BigSmallDataTypeVo> getAllBigSmallDataType();


    SmallDataType getSmallDataTypeByEnglishName(@Param("bigDataTypeId") Integer bigDataTypeId, @Param("dataTypeEnglish") String dataTypeEnglish);

}
