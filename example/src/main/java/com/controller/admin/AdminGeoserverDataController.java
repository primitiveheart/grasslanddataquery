package com.controller.admin;

import it.geosolutions.geoserver.rest.GeoServerRESTReader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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

    @RequestMapping("newWorkspace.html")
    public String newWorkspace(){
        return "admin/new-workspace";
    }

    @RequestMapping("dataStore.html")
    public String dataStore(){
        return "admin/data-store";
    }

    @RequestMapping("layer.html")
    public String layer(){
        return "admin/layer";
    }

    @RequestMapping("newLayer.html")
    public String newLayer(HttpServletRequest request) throws Exception{
        GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");
        List<String> layerNames = reader.getLayers().getNames();

        request.setAttribute("layerNames" , layerNames);
        return "admin/new-layer";
    }
}
