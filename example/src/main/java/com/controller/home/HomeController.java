package com.controller.home;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.entity.*;
import com.mapper.ApplyDataMapper;
import com.mapper.BigDataTypeMapper;
import com.mapper.SmallDataTypeMapper;
import com.mapper.UserMapper;
import com.util.JSONType;
import com.util.ResponseUtil;
import com.util.ToolUtils;
import com.vo.BigSmallDataTypeVo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;


/**
 * Created by admin on 2017/10/9.
 */
@Controller
@RequestMapping("home")
public class HomeController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @Autowired
    private SmallDataTypeMapper smallDataTypeMapper;

    @Autowired
    private BigDataTypeMapper bigDataTypeMapper;

    @RequestMapping("home.html")
    public String commit(HttpServletRequest request){
        //得到所有的大小数据类型
        List<BigSmallDataTypeVo> bigSmallDataTypeVoList = smallDataTypeMapper.getAllBigSmallDataType();
        //创建key为大数据类型，value为所有的大数据类型下的小数据类型
        Map<String, List<BigSmallDataTypeVo>> bigSmallDataTypeVoMap = new HashMap<String, List<BigSmallDataTypeVo>>();

        for(BigSmallDataTypeVo bigSmallDataTypeVo : bigSmallDataTypeVoList){
            if(bigSmallDataTypeVoMap.containsKey(bigSmallDataTypeVo.getbDataType())){
                bigSmallDataTypeVoMap.get(bigSmallDataTypeVo.getbDataType()).add(bigSmallDataTypeVo);
            }else{
                List<BigSmallDataTypeVo> bigSmallDataTypeVos = new ArrayList<BigSmallDataTypeVo>();
                bigSmallDataTypeVos.add(bigSmallDataTypeVo);
                bigSmallDataTypeVoMap.put(bigSmallDataTypeVo.getbDataType(), bigSmallDataTypeVos);
            }
        }

        request.setAttribute("bigSmallDataTypeVos",bigSmallDataTypeVoMap);
        return "/home/home";
    }

    /**
     * 把前端的提交的数据保存到数据库中
     * @param request
     * @param queryData
     * @return
     */
    @RequestMapping(value = "saveApplyData.html", method = RequestMethod.POST)
    public String saveApplyData(HttpServletRequest request, QueryData queryData){
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");
        User user = userMapper.getUserByUsername(sessionUser.getUsername());

        //获取所有的大数据类型
        List<BigDataType> bigDataTypes = bigDataTypeMapper.acquiredAllBigDataType();

        if(user == null){
            return "redirect:home/login";
        }else {
            JSONObject dataJson = new JSONObject();
            //来判断请求中是否含有大数据类型的字段
            for(BigDataType bigDataType : bigDataTypes){
                String[] smallDataTypeEnglishs =  request.getParameterValues(bigDataType.getDataTypeEnglish());
                if(smallDataTypeEnglishs != null){
                    dataJson.put(bigDataType.getDataTypeEnglish(), smallDataTypeEnglishs);
                }
            }

            ApplyData applyData = new ApplyData();
            applyData.setCoordinate(queryData.getLatitude() + ";" + queryData.getLongitude());
            applyData.setStartTime(queryData.getStartYear());
            applyData.setEndTime(queryData.getEndYear());
            ;
            applyData.setStatus("审核中");
            applyData.setDataType(dataJson.toJSONString());
            applyData.setUserId(user.getId());

            applyDataMapper.addApplyData(applyData);
        }

        return "create-order-success";
    }
}
