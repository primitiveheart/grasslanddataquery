package com.controller;

import com.util.ToolUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/10/17.
 */
@Controller
public class ListController {

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
}
