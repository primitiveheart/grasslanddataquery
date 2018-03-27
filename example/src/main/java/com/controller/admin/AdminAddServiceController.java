package com.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.entity.BigDataType;
import com.entity.ServiceData;
import com.entity.SmallDataType;
import com.mapper.BigDataTypeMapper;
import com.mapper.ServiceDataMapper;
import com.mapper.SmallDataTypeMapper;
import com.util.ResponseUtil;
import com.vo.DatatableCriteria;
import com.vo.SmallDataTypeVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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

    @Autowired
    private SmallDataTypeMapper smallDataTypeMapper;

    @RequestMapping("addService.html")
    public String addService(HttpServletRequest request){

        List<BigDataType> bigDataTypes = bigDataTypeMapper.acquiredAllBigDataType();

        request.setAttribute("bigDataTypes", bigDataTypes);

        return "admin/addService";
    }

    @RequestMapping(value = "saveBigDataType.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveBigDataType(HttpServletResponse response, BigDataType bigDataType){
        JSONObject result = new JSONObject();

        try {
            bigDataTypeMapper.saveBigDataType(bigDataType);
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }

    /**
     * 保存小数据类型
     * @param response
     * @param smallDataTypeVo
     */
    @RequestMapping(value = "saveSmallDataType.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveSmallDataType(HttpServletResponse response, SmallDataTypeVo smallDataTypeVo){
        JSONObject result = new JSONObject();

        try{
            BigDataType bigDataType = bigDataTypeMapper.getBigDataTypeByName(smallDataTypeVo.getBigDataTypeEnglish());
            SmallDataType smallDataType = new SmallDataType(smallDataTypeVo, bigDataType);
            smallDataTypeMapper.saveSmallDataType(smallDataType);
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failuer");
        }

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("acquiredAllBigDataType.html")
    @ResponseBody
    public void acquiredAllBigDataType(HttpServletResponse response){
        JSONObject result = new JSONObject();

        List<BigDataType> list = bigDataTypeMapper.acquiredAllBigDataType();

//        List<String> types = new ArrayList<String>();
//        for(BigDataType bigDataType : list){
//            types.add(bigDataType.getDataType());
//        }

        result.put("bigDataTypes", list);


        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("acquireAllSmallDataType.html")
    @ResponseBody
    public void acquireAllSmallDataType(HttpServletResponse response, String name){
        JSONObject result = new JSONObject();
        //根据大数据类型(数据类型中文)查询数据
        BigDataType bigDataType = bigDataTypeMapper.getBigDataTypeByName(name);

        List<SmallDataType> list = smallDataTypeMapper.listAllSmallDataType(bigDataType.getId());

        result.put("smallDataTypes", list);

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
    public void listService(HttpServletResponse response, @ModelAttribute DatatableCriteria datatableCriteria){
        JSONObject result = new JSONObject();

        Integer recordsTotal = serviceDataMapper.serviceDataTotal();
        Integer recordsFiltered = serviceDataMapper.serviceDataTotal();
        List<ServiceData> list = serviceDataMapper.acquiredServiceDataPageData(datatableCriteria.getStart(), datatableCriteria.getLength());

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
