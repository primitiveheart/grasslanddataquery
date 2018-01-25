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

   List<ApplyData> acquiredPageData(@Param("start") Integer start, @Param("length") Integer length);

   void updateApplyData(ApplyData applyData);

   ApplyData acquiredApplyDataById(Integer id);
}
