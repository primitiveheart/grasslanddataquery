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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by admin on 2018/3/28.
 */
@Controller
@RequestMapping("admin")
public class AdminDataManagerController {

    private final static Logger LOGGER = LoggerFactory.getLogger(AdminDataManagerController.class);

    @Autowired
    private BigDataTypeMapper bigDataTypeMapper;

    @Autowired
    private SmallDataTypeMapper smallDataTypeMapper;

    @Autowired
    private ServiceDataMapper serviceDataMapper;

    @RequestMapping("bigDataType.html")
    public String bigDataType(){
        return "admin/big-data-type";
    }

    @RequestMapping(value = "saveBigDataType.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveBigDataType(HttpServletResponse response, BigDataType bigDataType){
        JSONObject result = new JSONObject();

        BigDataType queryBigDataType = bigDataTypeMapper.getBigDataTypeByEnglishName(bigDataType.getDataTypeEnglish());

        try {
            if(queryBigDataType == null){
                bigDataTypeMapper.saveBigDataType(bigDataType);
                result.put("msg", "success");
            }
        }catch (Exception e){
            result.put("msg", "failure");
            LOGGER.error("AdminDataManagerController saveBigDataType插入异常");
        }

        ResponseUtil.renderJson(response, result);
    }


    @RequestMapping("smallDataType.html")
    public String smallDataType(HttpServletRequest request){
        List<BigDataType> bigDataTypes = bigDataTypeMapper.acquiredAllBigDataType();

        request.setAttribute("bigDataTypes", bigDataTypes);
        return "admin/small-data-type";
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
            BigDataType bigDataType = bigDataTypeMapper.getBigDataTypeByEnglishName(smallDataTypeVo.getBigDataTypeEnglish());
            SmallDataType querySmallDataType = smallDataTypeMapper.getSmallDataTypeByEnglishName(bigDataType.getId(), smallDataTypeVo.getDataTypeEnglish());
            if(querySmallDataType == null){
                SmallDataType smallDataType = new SmallDataType(smallDataTypeVo, bigDataType);
                smallDataTypeMapper.saveSmallDataType(smallDataType);
                result.put("msg", "success");
            }
        }catch (Exception e){
            result.put("msg", "failure");
            LOGGER.error("AdminDataManagerController saveSmallDataType 插入异常");
        }

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("addServiceData.html")
    public String addServiceData(HttpServletRequest request){
        List<BigDataType> bigDataTypes = bigDataTypeMapper.acquiredAllBigDataType();

        request.setAttribute("bigDataTypes", bigDataTypes);
        return "admin/add-service-data";
    }

    @RequestMapping("acquireAllSmallDataType.html")
    @ResponseBody
    public void acquireAllSmallDataType(HttpServletResponse response, String name){
        JSONObject result = new JSONObject();
        //根据大数据类型(数据类型中文)查询数据
        BigDataType bigDataType = bigDataTypeMapper.getBigDataTypeByChineseName(name);

        List<SmallDataType> list = smallDataTypeMapper.listAllSmallDataType(bigDataType.getId());

        result.put("smallDataTypes", list);

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping(value = "saveServiceData.html", method = RequestMethod.POST)
    @ResponseBody
    public void saveBigDataType(HttpServletResponse response, ServiceData serviceData){
        JSONObject result = new JSONObject();
        ServiceData queryServiceData = serviceDataMapper.getServiceDataByLayer(serviceData.getLayer());
        try {
            if(queryServiceData == null){
                serviceDataMapper.addServiceData(serviceData);
            }
            result.put("msg", "success");
        }catch (Exception e){
            result.put("msg", "failure");
        }

        ResponseUtil.renderJson(response, result);
    }


    @RequestMapping("listServiceData.html")
    public String listServiceData(){
        return "admin/list-service-data";
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
