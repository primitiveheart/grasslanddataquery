package com.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.BBox;
import com.entity.QueryData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.UserMapper;
import com.util.JSONType;
import com.util.ResponseUtil;
import com.util.ToolUtils;
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
public class QueryController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @RequestMapping("query.html")
    public String commit(){
        return "query";
    }

    @RequestMapping(value = "saveApplyData.html", method = RequestMethod.POST)
    public String saveApplyData(HttpServletRequest request, QueryData queryData){
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");
        User user = userMapper.getUserByUsername(sessionUser.getUsername());

        JSONObject dataJson = new JSONObject();
        if(queryData.getWeather() != null && queryData.getWeather().length != 0){
            dataJson.put("weather", queryData.getWeather());
        }
        if(queryData.getTerrain() != null && queryData.getTerrain().length != 0){
            dataJson.put("terrain", queryData.getTerrain());
        }
        if(queryData.getSoil() != null && queryData.getSoil().length() != 0){
            dataJson.put("soil", queryData.getSoil());
        }
        if(queryData.getCarbon() != null && queryData.getCarbon().length != 0){
            dataJson.put("carbin", queryData.getCarbon());
        }
        if(queryData.getVegetation() != null && queryData.getVegetation().length != 0){
            dataJson.put("vegetation", queryData.getVegetation());
        }

        ApplyData applyData = new ApplyData();
        applyData.setCoordinate(queryData.getLatitude() + ";" + queryData.getLongitude());
        applyData.setStartTime(queryData.getStartYear());
        applyData.setEndTime(queryData.getEndYear());;
        applyData.setStatus("审核中");
        applyData.setDataType(dataJson.toJSONString());
        applyData.setUserId(user.getId());

        applyDataMapper.addApplyData(applyData);

        return "create-order-success";
    }

    @RequestMapping(value = "coordResult.html", method = RequestMethod.POST)
    public String coordResult(HttpServletRequest request, HttpServletResponse response, QueryData queryData){
        //构建结果
        JSONObject resultJson = new JSONObject();
        JSONObject select = new JSONObject();
        String latitude = null ,longitude = null;
        Integer startYear = null, endYear = null;
        if(StringUtils.isNotEmpty(queryData.getLatitude())){
            latitude = queryData.getLatitude();
        }
        if(StringUtils.isNotEmpty(queryData.getLongitude())){
            longitude = queryData.getLongitude();
        }
        if(StringUtils.isNotEmpty(queryData.getStartYear())){
            startYear = Integer.valueOf(queryData.getStartYear());
        }
        if(StringUtils.isNotEmpty(queryData.getEndYear())){
            endYear = Integer.valueOf(queryData.getEndYear());
        }
        //得到气象数据
        if(queryData.getWeather() != null){
            JSONObject weatherResult = getWeatherData(queryData.getWeather(), latitude, longitude, startYear, endYear, select);
            resultJson.put("weather", weatherResult);
        }
        //得到固碳现状数据
        if(queryData.getCarbon() != null){
//            JSONObject carbonResult = getCarbonData(queryData.getCarbon(), latitude, longitude, startYear, endYear., select);
//            resultJson.put("carbon", carbonResult);
        }
        //得到植被数据
        if(queryData.getVegetation() != null){
        }
        //得到土壤数据
        if(queryData.getSoil() != null){
        }
        //得到地形数据
        if(queryData.getTerrain() != null) {
        }
        select.put("latitude", latitude);
        select.put("longitude", longitude);
        select.put("startYear", startYear);
        select.put("endYear", endYear);
        select.put("long", endYear - startYear + 1);
        select.put("month" , 12);


        request.setAttribute("resultJson", resultJson);
        request.setAttribute("select", select);

        return "coordResult";
    }

    @RequestMapping(value = "result.html", method = RequestMethod.POST)
    @ResponseBody
    public void query(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String jData){
        JSONObject jsonObject = JSONObject.parseObject(jData);
        JSONObject resultJson = new JSONObject(); //构建结果
        String weather = null, carbon = null, vegetation = null, soil = null, terrain = null ,latitude = null ,longitude = null;
        Integer startYear = null, endYear = null;
        if(StringUtils.isNotEmpty(jsonObject.getString("latitude"))){
            latitude = jsonObject.getString("latitude");
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("longitude"))){
            longitude = jsonObject.getString("longitude");
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("startYear"))){
            startYear = Integer.valueOf(jsonObject.getString("startYear"));

            if(startYear < 1981){
                startYear = 1981;
            }
            if(startYear > 2013){
                startYear = 2013;
            }
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("endYear"))){
            endYear = Integer.valueOf(jsonObject.getString("endYear"));

            if(endYear > 2013){
                endYear = 2013;
            }
            if(endYear < 1981){
                endYear = 1981;
            }
        }
        //得到气象数据
        if(StringUtils.isNotEmpty(jsonObject.getString("weather"))){
            JSONObject weatherResult = getWeatherData(jsonObject, latitude, longitude, startYear, endYear);
            resultJson.put("weather", weatherResult);
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("carbon"))){
//            JSONObject carbonResult = getCarbonData(jsonObject, latitude, longitude, startYear, endYear);
//            resultJson.put("carbon", carbonResult);
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("vegetation"))){
            vegetation = jsonObject.getString("vegetation");
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("soil"))){
            soil = jsonObject.getString("soil");
        }
        if(StringUtils.isNotEmpty(jsonObject.getString("terrain"))){
            terrain = jsonObject.getString("terrain");
        }
        resultJson.put("startYear", startYear);
        resultJson.put("endYear", endYear);
        //根据前端提交选项，构建页面结果，返回结果
        ResponseUtil.renderJson(response, resultJson);
    }

    public JSONObject getCarbonData(String[] type, String latitude, String longitude, Integer startYear, Integer endYear, JSONObject select){
        JSONObject carbonResult = new JSONObject();
        List<String> typeList = Arrays.asList(type);
        if(typeList.contains("vegetationPrimaryProductivity")){
            getVegetationPrimaryProductivity(latitude, longitude, startYear, endYear, carbonResult);
            select.put("vegetationPrimaryProductivity", 1);
        }
        if(typeList.contains("storageOfSoilOrganicCarbon")){
            getStorageOfSoilOrganicCarbon(latitude, longitude, startYear, endYear, carbonResult);
            select.put("storageOfSoilOrganicCarbon", 1);
        }
        return carbonResult;
    }

    public JSONObject getCarbonData(JSONObject jsonObject, String latitude, String longitude, Integer startYear, Integer endYear) {
        JSONObject carbonResult = new JSONObject();
        String carbon = jsonObject.getString("carbon");
        JSONType jsonType = ToolUtils.getJSONType(carbon);
        if(JSONType.JSON_TYPE_ARRAY == jsonType){
            JSONArray carbonJson = JSON.parseArray(carbon);
            if(carbonJson != null){
                if(carbonJson.contains("vegetationPrimaryProductivity")){
                    getVegetationPrimaryProductivity(latitude, longitude, startYear, endYear, carbonResult);
                }
                if(carbonJson.contains("storageOfSoilOrganicCarbon")){
                    getStorageOfSoilOrganicCarbon(latitude, longitude, startYear, endYear, carbonResult);
                }
            }
        }else if(JSONType.JSON_TYPE_OBJECT == jsonType || (JSONType.JSON_TYPE_EEROR == jsonType && StringUtils.isNotEmpty(carbon))){
            if(carbon.contains("vegetationPrimaryProductivity")){
                getVegetationPrimaryProductivity(latitude, longitude, startYear, endYear, carbonResult);
            }else if(carbon.contains("storageOfSoilOrganicCarbon")){
                getStorageOfSoilOrganicCarbon(latitude, longitude, startYear, endYear, carbonResult);
            }
        }
        return carbonResult;
    }

    private void getVegetationPrimaryProductivity(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject carbonResult) {
        List<String> allVegetationPrimaryProductivity = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++){
            String querys_VegetationPrimaryProductivity = "grassLandCoverage:vegetationPrimaryProductivity_" + i;
            String vegetationPrimaryProductivity = buildPath(querys_VegetationPrimaryProductivity, querys_VegetationPrimaryProductivity, longitude, latitude);
            String middle_band = ToolUtils.getTemp(vegetationPrimaryProductivity);
            allVegetationPrimaryProductivity.add(middle_band);
        }
        carbonResult.put("vegetationPrimaryProductivity", allVegetationPrimaryProductivity);
    }

    private void getStorageOfSoilOrganicCarbon(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject carbonResult) {
        List<String> allStorageOfSoilOrganicCarbon = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++){
            String querys_StorageOfSoilOrganicCarbon = "grassLandCoverage:storageOfSoilOrganicCarbon_" + i;
            String storageOfSoilOrganicCarbon = buildPath(querys_StorageOfSoilOrganicCarbon, querys_StorageOfSoilOrganicCarbon, longitude, latitude);
            String middle_band = ToolUtils.getTemp(storageOfSoilOrganicCarbon);
            allStorageOfSoilOrganicCarbon.add(middle_band);
        }
        carbonResult.put("storageOfSoilOrganicCarbon", allStorageOfSoilOrganicCarbon);
    }

    public JSONObject getWeatherData(String[] type, String latitude, String longitude, Integer startYear, Integer endYear, JSONObject select){
        JSONObject weatherResult = new JSONObject();
        List<String> typeList = Arrays.asList(type);
        if(typeList.contains("tempature_min")){
            getTeapatureMin(latitude, longitude, startYear, endYear, weatherResult);
            select.put("tempature_min", 1);
        }
        if(typeList.contains("tempature_max")){
            getTempatureMax(latitude, longitude, startYear, endYear, weatherResult);
            select.put("tempature_max", 1);
        }
        if(typeList.contains("tempature_average")){
            getTempatureAverage(latitude, longitude, startYear, endYear, weatherResult);
            select.put("tempature_average", 1);
        }
        if(typeList.contains("sumRainfall")){
            getSumRainfall(latitude, longitude, startYear, endYear, weatherResult);
            select.put("sumRainfall", 1);
        }
        if(typeList.contains("solarRadition")){
            getSolarRadition(latitude, longitude, startYear, endYear, weatherResult);
            select.put("solarRadition", 1);
        }
        return weatherResult;
    }

    public JSONObject getWeatherData(JSONObject jsonObject, String latitude, String longitude, Integer startYear, Integer endYear) {
        JSONObject weatherResult = new JSONObject();
        String weather = jsonObject.getString("weather");
        JSONType jsonType = ToolUtils.getJSONType(weather);
        //json数组
        if(JSONType.JSON_TYPE_ARRAY == jsonType){
            JSONArray weatherJson = JSON.parseArray(weather);
            if(weatherJson != null){
                if(weatherJson.contains("tempature_min")){
                    getTeapatureMin(latitude, longitude, startYear, endYear, weatherResult);
                }
                if(weatherJson.contains("tempature_max")){
                    getTempatureMax(latitude, longitude, startYear, endYear, weatherResult);
                }
                if(weatherJson.contains("tempature_average")){
                    getTempatureAverage(latitude, longitude, startYear, endYear, weatherResult);
                }
                if(weatherJson.contains("sumRainfall")){
                    getSumRainfall(latitude, longitude, startYear, endYear, weatherResult);
                }
                if(weatherJson.contains("solarRadition")){
                    getSolarRadition(latitude, longitude, startYear, endYear, weatherResult);
                }
            }
        }else if(JSONType.JSON_TYPE_OBJECT == jsonType || (JSONType.JSON_TYPE_EEROR == jsonType && StringUtils.isNotEmpty(weather))){//json对象
            if(weather.contains("tempature_min")){
                getTeapatureMin(latitude, longitude, startYear, endYear, weatherResult);
            }else if(weather.contains("tempature_max")){
                getTempatureMax(latitude, longitude, startYear, endYear, weatherResult);
            }else if(weather.contains("tempature_average")){
                getTempatureAverage(latitude, longitude, startYear, endYear, weatherResult);
            }else if(weather.contains("sumRainfall")){
                getSumRainfall(latitude, longitude, startYear, endYear, weatherResult);
            }else if(weather.contains("solarRadition")){
                getSolarRadition(latitude, longitude, startYear, endYear, weatherResult);
            }
        }
        return weatherResult;
    }

    /**
     * 根据选择年份获取所有太阳辐射的数据
     * @param latitude
     * @param longitude
     * @param startYear
     * @param endYear
     * @param weatherResult
     */
    public void getSolarRadition(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject weatherResult) {
        List<String> allSolarRadition = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++){
            String querys_SolarRadition = "grassLandCoverage:solarRadition_" + i;
            String solarRadition = buildPath(querys_SolarRadition, querys_SolarRadition, longitude, latitude);
            String middle_band = ToolUtils.getTemp(solarRadition);
            allSolarRadition.add(middle_band);
        }
        weatherResult.put("solarRadition", allSolarRadition);
    }

    /**
     * 根据选择年份获取累积降雨量的所有的数据
     * @param latitude
     * @param longitude
     * @param startYear
     * @param endYear
     * @param weatherResult
     */
    public void getSumRainfall(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject weatherResult) {
        List<String> allSumRainfall = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++ ){
            String querys_sumRainfall = "grassLandCoverage:sumRainfall_" + i;
            String sumRainfall = buildPath(querys_sumRainfall, querys_sumRainfall, longitude ,latitude);
            String middle_band = ToolUtils.getTemp(sumRainfall);
            allSumRainfall.add(middle_band);
        }
        weatherResult.put("sumRainfall", allSumRainfall);
    }

    /**
     * 根据选择年份获取平均温度的所有的数据
     * @param latitude
     * @param longitude
     * @param startYear
     * @param endYear
     * @param weatherResult
     */
    public void getTempatureAverage(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject weatherResult) {
        List<String> allTempatureAverage = new ArrayList<String>();
        for(int i = startYear ; i<= endYear ; i++){
            String querys_average = "grassLandCoverage:tempature_average_" + i;
            String tempature_average = buildPath(querys_average,querys_average, longitude, latitude);
            String middle_band = ToolUtils.getTemp(tempature_average);
            allTempatureAverage.add(middle_band);
        }
        weatherResult.put("tempature_average", allTempatureAverage);
    }

    /**
     * 根据选择年份获取最高温度的所有的数据
     * @param latitude
     * @param longitude
     * @param startYear
     * @param endYear
     * @param weatherResult
     */
    public void getTempatureMax(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject weatherResult) {
        List<String> allTempatureMax = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++){
            String querys_max = "grassLandCoverage:tempature_max_" + i;
            String tempature_max = buildPath(querys_max, querys_max, longitude, latitude);
            String middle_band = ToolUtils.getTemp(tempature_max);
            allTempatureMax.add(middle_band);
        }
        weatherResult.put("tempature_max", allTempatureMax);
    }

    /**
     * 根据选择的年份最低温度获取所有的数据
     * @param latitude
     * @param longitude
     * @param startYear
     * @param endYear
     * @param weatherResult
     */
    public void getTeapatureMin(String latitude, String longitude, Integer startYear, Integer endYear, JSONObject weatherResult) {
        List<String> allTempatureMin = new ArrayList<String>();
        for(int i = startYear; i <= endYear; i++){
            String querys_min = "grassLandCoverage:tempature_min_" + i;
            String tempature_min = buildPath(querys_min, querys_min, longitude, latitude);
            String middle_band = ToolUtils.getTemp(tempature_min);
            allTempatureMin.add(middle_band);
        }
        weatherResult.put("tempature_min", allTempatureMin);
    }


    /**
     * 构建geoserver的wms的一般路径
     * @param layers
     * @param query_layers
     * @param longitude
     * @param latitude
     * @return
     */
    public String buildPath(String layers, String query_layers, String longitude, String latitude) {
       BBox bBox = new BBox(73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392);
       String bbox  = bBox.getX() + "," + bBox.getY() + "," + bBox.getWidth() + "," + bBox.getHeight();
//       String layers = "grassLandCoverage:geotools_coverage_3";
//       String query_layers = "grassLandCoverage:geotools_coverage_3";
       String width = "768";
       String height = "444";
       String x = longitude;
       String y = latitude;
       String url = "http://localhost:8080/geoserver/wms";
       String param = "bbox="+ bbox +"&info_format=text/plain&request=GetFeatureInfo&" +
               "layers=" + layers + "&query_layers=" + query_layers + "&width=" + width + "&height=" + height + "&x=" + x + "&y=" + y;
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
