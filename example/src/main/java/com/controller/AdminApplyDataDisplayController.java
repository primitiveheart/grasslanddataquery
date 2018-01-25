package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import com.vo.ApplyDataVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2018/1/24.
 */
@Controller
@RequestMapping("admin")
public class AdminApplyDataDisplayController {

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @Autowired
    private UserMapper userMapper;

    @RequestMapping(value = "acquireApplyData.html")
    @ResponseBody
    public void acquireApplyData(HttpServletResponse response, @RequestParam(required = false) Integer draw,
                                 @RequestParam(required = false) Integer start, @RequestParam(required = false)Integer length){
        JSONObject result = new JSONObject();

        Integer recordsTotal = applyDataMapper.applyDataTotal();
        Integer recordsFiltered = applyDataMapper.applyDataTotal();
        List<ApplyData> page = applyDataMapper.acquiredPageData(start, length);

        List<ApplyDataVO> data = new ArrayList<ApplyDataVO>();
        for(int i=0; i<page.size(); i++){
            ApplyData applyData = page.get(i);
            User user = userMapper.getUserById(applyData.getUserId());
            ApplyDataVO applyDataVO = new ApplyDataVO(applyData);
            applyDataVO.setUsername(user.getUsername());
            String coordinate = applyData.getCoordinate();
            applyDataVO.setCoordinate("纬度: " + coordinate.split(";")[0] + " 经度: " + coordinate.split(";")[1]);
            data.add(applyDataVO);
        }

        result.put("recordsTotal", recordsTotal);
        result.put("recordsFiltered", recordsFiltered);
        result.put("data", data);

        ResponseUtil.renderJson(response, result);
    }


    /**
     * @param response
     * @param id applydata类中的id
     */
    @RequestMapping(value = "updateApplyData.html", method = RequestMethod.POST)
    @ResponseBody
    public void updateApplyData(HttpServletResponse response , Integer id){
        //根据id获取applydata数据
        ApplyData applyData = applyDataMapper.acquiredApplyDataById(id);
        if(applyData.getStatus().equals("审核中")){
            //更新数据
            if(applyData != null){
                applyData.setStatus("审核通过");
                applyDataMapper.updateApplyData(applyData);
            }
        }
        if(applyData.getStatus().equals("审核通过")){
            //更新数据
            if(applyData != null){
                applyData.setStatus("审核中");
                applyDataMapper.updateApplyData(applyData);
            }
        }
    }


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
}
