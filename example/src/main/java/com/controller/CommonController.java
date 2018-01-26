package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.util.ResponseUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by admin on 2018/1/26.
 */
@Controller
public class CommonController {

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
