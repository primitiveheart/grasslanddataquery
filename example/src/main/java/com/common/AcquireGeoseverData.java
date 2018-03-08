package com.common;

import com.alibaba.fastjson.JSONObject;
import com.entity.BBox;
import com.entity.ServiceData;
import com.util.ToolUtils;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2018/3/8.
 */
@Component
public class AcquireGeoseverData {
    /**
     * @param latitude
     * @param longitude
     * @param layerName
     * @return
     */
    public JSONObject getBigDataType(String latitude, String longitude, List<ServiceData> layerName){
        JSONObject bigDataTypes = new JSONObject();
        List<String> smallDataTypes = getSmallDataType(latitude, longitude, layerName);
        bigDataTypes.put("data", smallDataTypes);
        return bigDataTypes;
    }

    /**
     * @param latitude
     * @param longitude
     * @param layerName
     * @return
     */
    public List<String> getSmallDataType(String latitude, String longitude, List<ServiceData> layerName){
        List<String> smallDataTypes = new ArrayList<String>();
        for(ServiceData serviceData : layerName){
            String layer = serviceData.getLayer();
            //构建url
            String tempature_min = buildPath(layer,longitude, latitude);
            //解析结果
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
        String url = "http://localhost:8080/grassLandCoverage/wms";
        String param = "bbox="+ bbox +"&info_format=text/plain&format=application/openlayers&request=GetFeatureInfo&" +
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
    public String sendGet(String url, String param){
        String result = "";
        BufferedReader br = null;
        try{
            String urlNameString = url + "?" + param;
            //正确的访问路径
            //http://localhost:8080/grassLandCoverage/wms?
            // bbox=73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392&styles=&
            // format=text%2Fhtml%3B+subtype%3Dopenlayers&info_format=text/plain&request=GetFeatureInfo&layers=grassLandCoverage:tempature_min_1981&query_layers=grassLandCoverage:tempature_min_1981&width=768&height=444&x=170&y=160
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
