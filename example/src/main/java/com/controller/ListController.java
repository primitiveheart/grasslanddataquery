package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import com.util.ToolUtils;
import com.vo.ApplyDataVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/10/17.
 */
@Controller
public class ListController {

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @Autowired
    private UserMapper userMapper;

    @RequestMapping(value = "acquireApplyData.html")
    @ResponseBody
    public void acquireApplyData(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) Integer draw,
                                 @RequestParam(required = false) Integer start, @RequestParam(required = false)Integer length){
        User existUser = (User) request.getSession().getAttribute("user");
        JSONObject result = new JSONObject();

        Integer recordsTotal = applyDataMapper.applyDataTotal();
        Integer recordsFiltered = applyDataMapper.applyDataTotal();
        List<ApplyData> page = applyDataMapper.acquiredPageDataByUserId(start, length, existUser.getId());

        List<ApplyDataVO> data = new ArrayList<ApplyDataVO>();
        for(int i=0; i<page.size(); i++){
            ApplyData applyData = page.get(i);
            ApplyDataVO applyDataVO = new ApplyDataVO(applyData);
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
     * @param request
     * @return
     */
    @RequestMapping("dataYear.html")
    public String getDataYear(HttpServletRequest request, String type){
        List<String> allYear = new ArrayList<String>();
        for(int i = 1981; i <= 2013 ;i++){
            allYear.add(i + "");
        }
        Map<String, String> map = ToolUtils.getDataType();

        request.setAttribute("allYear", allYear);
        request.setAttribute(type, type);
        request.setAttribute("name", map.get(type));
        return "data-year-list";
    }

    @RequestMapping("lookupResult.html")
    public String lookupResult(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null){
            return "forward:login.html";
        }else{
            return "lookup-result";
        }
    }
}
