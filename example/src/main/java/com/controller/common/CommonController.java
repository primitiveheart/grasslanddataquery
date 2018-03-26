package com.controller.common;

import com.alibaba.fastjson.JSONObject;
import com.common.AcquireGeoseverData;
import com.entity.ApplyData;
import com.entity.ServiceData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.ServiceDataMapper;
import com.mapper.SmallDataTypeMapper;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import com.vo.BigSmallDataTypeVo;
import com.vo.DataTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2018/1/26.
 */
@Controller
@RequestMapping("common")
public class CommonController {

    @Autowired
    private ServiceDataMapper serviceDataMapper;

    @Autowired
    private AcquireGeoseverData acquireGeoseverData;

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @Autowired
    private SmallDataTypeMapper smallDataTypeMapper;

    @RequestMapping("chinese.json")
    @ResponseBody
    public void chinese(HttpServletResponse response){
        JSONObject language = new JSONObject();

        JSONObject paginattion = new JSONObject();
        paginattion.put("sFirst", "首页");
        paginattion.put("sPrevious", "前一页");
        paginattion.put("sNext", "后一页");
        paginattion.put("sLast", "尾页");

        language.put("sLengthMenu" , "每页显示 _MENU_ 条记录");
        language.put("sInfo", "从 _START_ 到 _END_ /共 _TOTAL_ 条数据");
        language.put("sSearch", "搜索");
        language.put("sZeroRecords", "抱歉! 没有找到");
        language.put("sInfoEmpty", "没有数据");
        language.put("oPaginate", paginattion);

        ResponseUtil.renderJson(response, language);
    }

    @RequestMapping("lookup.html")
    public String lookup(HttpServletRequest request, Integer id){
        //根据申请的数据的id来查询申请数据
        ApplyData applyData = applyDataMapper.queryApplyDataById(id);

        //获取的是数据类型
        String dataType = applyData.getDataType();

        String latitude = applyData.getCoordinate().split(";")[1];
        String longitude= applyData.getCoordinate().split(";")[0];
        String pixelX = applyData.getPixel().split(";")[0];
        String pixelY = applyData.getPixel().split(";")[1];
        Integer startYear= Integer.valueOf(applyData.getStartTime());
        Integer endYear= Integer.valueOf(applyData.getEndTime());

        JSONObject dataTypeJson = JSONObject.parseObject(dataType);

        //大数据类和小数据类型
        Map<String, String> bigSmallDataType = new HashMap<String, String>();
        for(Map.Entry entry : dataTypeJson.entrySet()){
            bigSmallDataType.put(entry.getKey().toString(), entry.getValue().toString().replaceAll("\\]","").replaceAll("\\[" ,""));
        }

        //获取大小数据类型
        List<BigSmallDataTypeVo> bigSmallDataTypeVos = new ArrayList<BigSmallDataTypeVo>();
        for(Map.Entry<String, String> entry: bigSmallDataType.entrySet()){
            if(entry.getValue().contains(",")){
                for(int i=0; i< entry.getValue().split(",").length; i++){
                    BigSmallDataTypeVo bigSmallDataTypeVo = smallDataTypeMapper.getBigSmallDataType(entry.getKey(), entry.getValue().split(",")[i].replaceAll("\"",""));
                    bigSmallDataTypeVos.add(bigSmallDataTypeVo);
                }
            }else{
                BigSmallDataTypeVo bigSmallDataTypeVo = smallDataTypeMapper.getBigSmallDataType(entry.getKey(), entry.getValue().replaceAll("\"",""));
                bigSmallDataTypeVos.add(bigSmallDataTypeVo);
            }
        }

        Map<String, List<BigSmallDataTypeVo>> bigSmallDataTypeVoMap = new HashMap<String, List<BigSmallDataTypeVo>>();
        for(BigSmallDataTypeVo bigSmallDataTypeVo : bigSmallDataTypeVos){
            if(!bigSmallDataTypeVoMap.containsKey(bigSmallDataTypeVo.getbDataType())){
                List<BigSmallDataTypeVo> bigSmallDataTypeVoList = new ArrayList<BigSmallDataTypeVo>();
                bigSmallDataTypeVoList.add(bigSmallDataTypeVo);
                bigSmallDataTypeVoMap.put(bigSmallDataTypeVo.getbDataType(), bigSmallDataTypeVoList);
            }else{
                bigSmallDataTypeVoMap.get(bigSmallDataTypeVo.getbDataType()).add(bigSmallDataTypeVo);
            }
        }

        request.setAttribute("latitude", latitude);
        request.setAttribute("longitude", longitude);
        request.setAttribute("pixelX", pixelX);
        request.setAttribute("pixelY", pixelY);
        request.setAttribute("startYear", startYear);
        request.setAttribute("endYear", endYear);

        request.setAttribute("bigSmallDataTypeVoMap", bigSmallDataTypeVoMap);

        return "common/lookup";
    }

    @RequestMapping("acquireSmallDataTypeResult.html")
    @ResponseBody
    public void acquireSmallDataTypeResult(HttpServletResponse response, DataTypeVo dataTypeVo){
        //根据大数据类型，小数据类型，开始的年份和结束的年份查询到服务数据
        List<ServiceData> serviceDatas = serviceDataMapper.queryServiceDataByBigAndSmallDataTypeBetweenYear(dataTypeVo.getBigDataTypeEnglish(),
                dataTypeVo.getSmallDataTypeEnglish(), dataTypeVo.getStartYear(), dataTypeVo.getEndYear());

        JSONObject bigDataTypes = acquireGeoseverData.getBigDataType(dataTypeVo.getPixelX(), dataTypeVo.getPixelY(), serviceDatas);

        ResponseUtil.renderJson(response, bigDataTypes);
    }
}
