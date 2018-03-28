package com.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by admin on 2018/3/27.
 */
@Controller
@RequestMapping("admin")
public class AdminGeoserverDataController {

    @RequestMapping("workspace.html")
    public String workspace(){
        return "admin/workspace";
    }

    @RequestMapping("dataStore.html")
    public String dataStore(){
        return "admin/data-store";
    }

    @RequestMapping("layer.html")
    public String layer(){
        return "admin/layer";
    }
}
