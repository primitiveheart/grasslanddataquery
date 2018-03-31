package com.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.mysql.fabric.xmlrpc.base.Data;
import com.sun.org.apache.regexp.internal.RE;
import com.util.ResponseUtil;
import com.vo.DataStore;
import com.vo.DatatableCriteria;
import com.vo.Layer;
import com.vo.Workspace;
import it.geosolutions.geoserver.rest.GeoServerRESTPublisher;
import it.geosolutions.geoserver.rest.GeoServerRESTReader;
import it.geosolutions.geoserver.rest.decoder.RESTDataStoreList;
import it.geosolutions.geoserver.rest.decoder.RESTFeatureType;
import it.geosolutions.geoserver.rest.decoder.RESTLayer;
import it.geosolutions.geoserver.rest.decoder.RESTLayerList;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2018/3/29.
 */
@Controller
@RequestMapping("admin")
public class GeoserverRestController {


    @RequestMapping(value = "namespaces.json", method = RequestMethod.POST)
    @ResponseBody
    public void namespacesPost(HttpServletResponse response, String name, String uri) throws Exception{
        JSONObject result = new JSONObject();
        GeoServerRESTPublisher publisher = new GeoServerRESTPublisher("http://localhost:8080", "admin", "geoserver");
            boolean created = publisher.createWorkspace(name,new URI(uri));
        //表示创建成功
       if(created){
           result.put("msg", "success");
       }else{
           result.put("msg", "failure");
       }

       ResponseUtil.renderJson(response, result);
    }

    @RequestMapping(value = "workspaces.json",method = RequestMethod.GET)
    @ResponseBody
    public void workspaces(HttpServletResponse response, @ModelAttribute DatatableCriteria datatableCriteria)throws Exception{
        JSONObject result = new JSONObject();

        List<Workspace> workspaces = new ArrayList<Workspace>();

        GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");
        List<String> workspaceNames = reader.getWorkspaceNames();
        for(int i=0; i < workspaceNames.size(); i++){
            Workspace workspace = new Workspace(workspaceNames.get(i));
            workspaces.add(workspace);
        }

        List<Workspace> page = getPage(datatableCriteria, workspaces);


        Integer recordsTotal = workspaces.size();
        Integer recordsFiltered = workspaces.size();

        result.put("recordsTotal", recordsTotal);
        result.put("recordsFiltered", recordsFiltered);
        result.put("data", page);

        ResponseUtil.renderJson(response, result);
    }

    @RequestMapping("dataStore.json")
    @ResponseBody
    public void dataStore(HttpServletResponse response, @ModelAttribute DatatableCriteria datatableCriteria) throws Exception{
        JSONObject result = new JSONObject();

        List<DataStore> dataStores = new ArrayList<DataStore>();

        GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");
        List<String> worlspaceNames = reader.getWorkspaceNames();
        for(int i=0; i<worlspaceNames.size(); i++){
            List<String> dataStoreNames  = reader.getDatastores(worlspaceNames.get(i)).getNames();
            if(dataStoreNames != null && dataStoreNames.size() > 0){
                for(int j = 0 ;j <dataStoreNames.size(); j++){
                    DataStore dataStore = new DataStore(worlspaceNames.get(i), dataStoreNames.get(j));
                    dataStores.add(dataStore);
                }
            }
        }
        List<DataStore> page = getPage(datatableCriteria, dataStores);



        Integer recordsTotal = dataStores.size();
        Integer recordsFiltered = dataStores.size();

        result.put("recordsTotal", recordsTotal);
        result.put("recordsFiltered", recordsFiltered);
        result.put("data", page);

        ResponseUtil.renderJson(response, result);
    }

    public <T> List<T> getPage(@ModelAttribute DatatableCriteria datatableCriteria, List<T> list) {
        List<T> page = new ArrayList<T>();

        for(int i = datatableCriteria.getStart(); datatableCriteria.getStart() < list.size() &&
                i < datatableCriteria.getStart() + datatableCriteria.getLength(); i++ ){
            if(datatableCriteria.getStart() + datatableCriteria.getLength() > list.size()){
                if(i<list.size()){
                    page.add(list.get(i));
                }
            }else{
                page.add(list.get(i));
            }
        }
        return page;
    }

    @RequestMapping(value = "layer.json", method = RequestMethod.GET)
    @ResponseBody
    public void layer(HttpServletResponse response, @ModelAttribute DatatableCriteria datatableCriteria) throws Exception{
        JSONObject result = new JSONObject();

        List<Layer> layers = new ArrayList<Layer>();
        GeoServerRESTReader reader = new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");
        List<String> layerNames  = reader.getLayers().getNames();

       for(int j =0; j <layerNames.size(); j++){
           RESTLayer restLayer = reader.getLayer(layerNames.get(j).split(":")[0], layerNames.get(j).split(":")[1]);
           if(restLayer != null){
               try{
                   RESTFeatureType restFeatureType =reader.getFeatureType(restLayer);
                   if(restFeatureType != null){
                       String type = restLayer.getType().name();
                       String crs = restFeatureType.getCRS();
                       String dataStore = restFeatureType.getStoreName().split(":")[1];
                       String title = restFeatureType.getTitle();
                       Layer layer = new Layer(type, title, layerNames.get(j).split(":")[0], layerNames.get(j).split(":")[1], dataStore, crs);
                       layers.add(layer);
                   }
               }catch (Exception e){
                   //TODO
               }
           }
       }

       List<Layer> page = getPage(datatableCriteria, layers);

        Integer recordsTotal = layerNames.size();
        Integer recordsFiltered = layerNames.size();

        result.put("recordsTotal", recordsTotal);
        result.put("recordsFiltered", recordsFiltered);
        result.put("data", page);

        ResponseUtil.renderJson(response, result);

    }

}
