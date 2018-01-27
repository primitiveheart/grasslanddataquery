package com.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.BBox;
import com.entity.ServiceData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.ServiceDataMapper;
import com.mapper.UserMapper;
import com.util.JSONType;
import com.util.ResponseUtil;
import com.util.ToolUtils;
import com.vo.ApplyDataVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.TagUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;

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

    @Autowired
    private ServiceDataMapper serviceDataMapper;

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
        }else if(applyData.getStatus().equals("审核通过")){
            //更新数据
            if(applyData != null){
                applyData.setStatus("审核中");
                applyDataMapper.updateApplyData(applyData);
            }
        }
    }

    @RequestMapping("lookup.html")
    public String lookup(HttpServletRequest request, Integer id){
        JSONObject result = new JSONObject();
        JSONObject resultSet = new JSONObject();

        ApplyData applyData = applyDataMapper.queryApplyDataById(id);

        String latitude = applyData.getCoordinate().split(";")[0];
        String longitude= applyData.getCoordinate().split(";")[1];
        Integer startYear= Integer.valueOf(applyData.getStartTime());
        Integer endYear= Integer.valueOf(applyData.getEndTime());

        String dataType = applyData.getDataType();
        JSONObject dataTypeJson = JSONObject.parseObject(dataType);
        Map<String, Map<String,List<ServiceData>>> map = new HashMap<String, Map<String,List<ServiceData>>>();

        for(Map.Entry entry : dataTypeJson.entrySet()){
            String key = (String) entry.getKey();
            Map<String, List<ServiceData>> smallDataTypeMap = new HashMap<String, List<ServiceData>>();
            if(JSONType.JSON_TYPE_ARRAY == ToolUtils.getJSONType(entry.getValue().toString())){
                JSONArray valueArray = JSON.parseArray(entry.getValue().toString());
                for(int i = 0 ; i < valueArray.size(); i++){
//                    if(key.contains("weather")){
//                        List<ServiceData> serviceDatas = serviceDataMapper.queryServiceDataByBigAndSmallDataTypeBetweenYear("气象数据", "最低温度(月)", startYear, endYear);
//                        smallDataTypeMap.put(valueArray.getString(i), serviceDatas);
//                        map.put(key, smallDataTypeMap);
//                    }
                    List<ServiceData> serviceDatas = serviceDataMapper.queryServiceDataByBigAndSmallDataTypeBetweenYear(key, valueArray.getString(i), startYear, endYear);
                    smallDataTypeMap.put(valueArray.getString(i), serviceDatas);
                    map.put(key, smallDataTypeMap);
                }
            }else if(JSONType.JSON_TYPE_OBJECT == ToolUtils.getJSONType(entry.getValue().toString())){
                String value = entry.getValue().toString();
                List<ServiceData> serviceDatas = serviceDataMapper.queryServiceDataByBigAndSmallDataTypeBetweenYear(key, value, startYear, endYear);
                smallDataTypeMap.put(value, serviceDatas);
                map.put(key, smallDataTypeMap);
            }
        }

       for(String key : map.keySet()){
           Map<String, List<ServiceData>> listMap = map.get(key);
           for(String smallDataTypeKey : listMap.keySet()){
               List<ServiceData> layerName = listMap.get(smallDataTypeKey);
               JSONObject bigDataTypes = getBigDataType(smallDataTypeKey, latitude, longitude, layerName);
               resultSet.put(key, bigDataTypes);
           }
       }

        result.put("latitude", latitude);
        result.put("longitude", longitude);
        result.put("startYear", startYear);
        result.put("endYear", endYear);
        result.put("long", endYear - startYear + 1);
        result.put("month" , 12);

        request.setAttribute("resultJson", resultSet);
        request.setAttribute("select", result);

        return "admin/lookup";
    }

    public JSONObject getBigDataType(String type, String latitude, String longitude, List<ServiceData> layerName){
        JSONObject bigDataTypes = new JSONObject();
        List<String> smallDataTypes = getSmallDataType(latitude, longitude, layerName);
        bigDataTypes.put(type, smallDataTypes);
        return bigDataTypes;
    }

    public List<String> getSmallDataType(String latitude, String longitude, List<ServiceData> layerName){
        List<String> smallDataTypes = new ArrayList<String>();
        for(ServiceData serviceData : layerName){
            String layer = serviceData.getLayer();
            String tempature_min = buildPath(layer,longitude, latitude);
            String middle_band = ToolUtils.getTemp(tempature_min);
            smallDataTypes.add(middle_band);
        }
        return smallDataTypes;
    }

    /**
     * 构建geoserver的wms的一般路径
     * @param layers
     * @param longitude
     * @param latitude
     * @return
     */
    public String buildPath(String layers, String longitude, String latitude) {
        BBox bBox = new BBox(73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392);
        String bbox  = bBox.getX() + "," + bBox.getY() + "," + bBox.getWidth() + "," + bBox.getHeight();
        String width = "768";
        String height = "444";
        String x = longitude;
        String y = latitude;
        String url = "http://localhost:8080/geoserver/wms";
        String param = "bbox="+ bbox +"&info_format=text/plain&request=GetFeatureInfo&" +
                "layers=" + layers + "&query_layers=" + layers + "&width=" + width + "&height=" + height + "&x=" + x + "&y=" + y;
       String temp = sendGet(url, param);
       return temp;
    }

    /**
     * 向geoserver的项目发送get方式
     * @param url
     * @param param
     * @return
     */
    @ModelAttribute
    public String sendGet(String url, String param){
        String result = "";
        BufferedReader br = null;
        try{
            String urlNameString = url + "?" + param;
            //String urlNameString = "http://localhost:8080/geoserver/wms?bbox=73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392&styles=&format=text%2Fhtml%3B+subtype%3Dopenlayers&info_format=text/plain&request=GetFeatureInfo&layers=cite:geotools_coverage_3&query_layers=cite:geotools_coverage_3&width=768&height=444&x=170&y=160";
            URL realUrl = new URL(urlNameString);
            //打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
//            HttpURLConnection connection = (HttpURLConnection) realUrl.openConnection();
            //设置通用的请求属性
//            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            //建立实际的连接
            connection.connect();
//            //获取所有的响应字段
//            Map<String, List<String>> map = connection.getHeaderFields();
//            //遍历所有的响应字段
//            for(String key : map.keySet()){
//
//            }
            //定义BufferedReader输入流来读取URL的响应
            br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while((line = br.readLine()) != null){
                result += line + ",";
            }
        }catch (Exception e){
            try{
                if(br != null){
                    br.close();
                }
            }catch (Exception e2){
                throw new RuntimeException(e2);
            }
        }
        return result;
    }
}
