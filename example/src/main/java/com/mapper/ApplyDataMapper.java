package com.mapper;

import com.entity.ApplyData;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2018/1/24.
 */
public interface ApplyDataMapper {
   void addApplyData(ApplyData applyData);

   Integer applyDataTotal();

   Integer applyDataTotalByUserId(Integer integer);

   List<ApplyData> acquiredPageData(@Param("start") Integer start, @Param("length") Integer length);

   List<ApplyData> acquiredPageDataByUserId(@Param("start") Integer start, @Param("length") Integer length, @Param("userId") Integer userId);

   void updateApplyData(ApplyData applyData);

   ApplyData queryApplyDataById(Integer id);

   ApplyData acquiredApplyDataById(Integer id);
}
