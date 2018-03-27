package com.mapper;

import com.entity.ApplyData;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2018/1/24.
 */
public interface ApplyDataMapper {
   void addApplyData(ApplyData applyData);

   Integer applyDataTotalByCondition(@Param("queryCondition") String queryCondition);

   // like '%${queryCondition}%'
   Integer applyDataTotalByUserIdAndCondition(@Param("userId") Integer userId, @Param("queryCondition") String queryCondition);

   Integer applyDataTotalByUserId(Integer userId);

   List<ApplyData> acquiredPageDataByCondition(@Param("start") Integer start, @Param("length") Integer length,
                                               @Param("queryCondition") String queryCondition);

   List<ApplyData> acquiredPageDataByUserId(@Param("start") Integer start, @Param("length") Integer length,
                                            @Param("userId") Integer userId);

   List<ApplyData> acquiredPageDataByUserIdAndCondition(@Param("start") Integer start, @Param("length") Integer length,
                                               @Param("userId") Integer userId, @Param("queryCondition") String queryCondition);

   void updateApplyData(ApplyData applyData);

   ApplyData queryApplyDataById(Integer id);

   ApplyData acquiredApplyDataById(Integer id);

   void deleteApplyData(Integer id);
}
