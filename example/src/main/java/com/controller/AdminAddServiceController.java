package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.BigDataType;
import com.entity.ServiceData;
import com.mapper.BigDataTypeMapper;
import com.mapper.ServiceDataMapper;
import com.sun.org.apache.regexp.internal.RE;
import com.util.ResponseUtil;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.executor.ExecutorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2018/1/26.
 */
@Controller
@RequestMapping("admin")
public class AdminAddServiceController {

    @Autowired
    private BigDataTypeMapper bigDataTypeMapper;

    @Autowired
    private ServiceDataMapper serviceDataMapper;

    @RequestMapping("addService.html")
    public String addService(){
        return "admin/addService";
    }

    @RequestMapping(value = "saveBigDataType.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveBigDataType(HttpServletResponse response, String dataType){
        JSONObject result = new JSONObject();

        try {
            bigDataTypeMapper.saveBigDataType(dataType);
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("acquiredAllBigDataType.html")
    @ResponseBody
    public void acquiredAllBigDataType(HttpServletResponse response){
        JSONObject result = new JSONObject();

        List<BigDataType> list = bigDataTypeMapper.acquiredAllBigDataType();
        List<String> types = new ArrayList<String>();
        for(BigDataType bigDataType : list){
            types.add(bigDataType.getDataType());
        }

        result.put("types", types);

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping(value = "saveServiceData.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveBigDataType(HttpServletResponse response, ServiceData serviceData){
        JSONObject result = new JSONObject();
        try {
            serviceDataMapper.addServiceData(serviceData);
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping(value = "listService.html", method = RequestMethod.POST)
    @ResponseBody
    public void listService(HttpServletResponse response, @RequestParam(required = false) Integer draw,
                            @RequestParam(required = false) Integer start, @RequestParam(required = false) Integer length){
        JSONObject result = new JSONObject();

        Integer recordsTotal = serviceDataMapper.serviceDataTotal();
        Integer recordsFiltered = serviceDataMapper.serviceDataTotal();
        List<ServiceData> list = serviceDataMapper.acquiredServiceDataPageData(start, length);

        result.put("recordsTotal", recordsTotal);
        result.put("recordsFiltered", recordsFiltered);
        result.put("data", list);

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("deleteServiceData.html")
    @ResponseBody
    public void deleteServiceData(HttpServletResponse response, Integer id){
        JSONObject result = new JSONObject();
        try{
            serviceDataMapper.deleteServiceData(id);
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping(value = "updateServiceData.html" ,method = RequestMethod.POST)
    @ResponseBody
    public void updateServiceData(HttpServletResponse response, ServiceData serviceData){
        JSONObject result = new JSONObject();
        try{
            serviceDataMapper.updateServiceData(serviceData);
            result.put("msg", "success");
        }catch (Exception e){
            e.printStackTrace();
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }
}
