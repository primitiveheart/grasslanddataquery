package com.common;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.entity.ServiceData;
import it.geosolutions.geoserver.rest.GeoServerRESTReader;
import it.geosolutions.geoserver.rest.decoder.RESTFeatureType;
import it.geosolutions.geoserver.rest.decoder.RESTLayer;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2018/3/8.
 */
@Component
public class AcquireGeoseverData {

    /**
     * @param pixelX
     * @param pixelY
     * @param layerName
     * @return
     */
    public JSONObject getBigDataType(String pixelX, String pixelY, List<ServiceData> layerName){
        JSONObject bigDataTypes = new JSONObject();
        try{
            List<String> smallDataTypes = getSmallDataType(pixelX, pixelY, layerName);
            bigDataTypes.put("data", smallDataTypes);
        }catch (Exception e){
            //TODO
        }

        return bigDataTypes;
    }


    /**
     * @param pixelX
     * @param pixelY
     * @param layerName
     * @return
     */
    public List<String> getSmallDataType(String pixelX, String pixelY, List<ServiceData> layerName) throws Exception{
        List<String> smallDataTypes = new ArrayList<String>();
        for(ServiceData serviceData : layerName){
            String workspace = serviceData.getWorkspace();
            String layer = serviceData.getLayer();
            //构建url
            String data = buildPath(workspace, layer, pixelX , pixelY);
            //解析结果
//            String middle_band = ToolUtils.getTemp(tempature_min);
            String middle_band = parserWMSBackData(data);
            smallDataTypes.add(middle_band);
        }
        return smallDataTypes;
    }


    /**
     * {
     "type": "FeatureCollection",
     "totalFeatures": "unknown",
     "features": [
     {
     "type": "Feature",
     "id": "",
     "geometry": null,
     "properties": {
     "Band1": -18.109079360961914,
     "Band2": -18.855497360229492,
     "Band3": -9.221680641174316,
     "Band4": 1.0766217708587646,
     "Band5": 6.3653974533081055,
     "Band6": 12.770868301391602,
     "Band7": 15.39113712310791,
     "Band8": 13.843870162963867,
     "Band9": 7.829655647277832,
     "Band10": 0.6163461208343506,
     "Band11": -6.789844989776611,
     "Band12": -17.50874137878418
     }
     }
     ],
     "crs": null
     }
     * @param data
     * @return
     */
    public String parserWMSBackData(String data){
        JSONObject jsonObject = JSONObject.parseObject(data);
        String features = jsonObject.getString("features");
        JSONArray jsonArray = JSONArray.parseArray(features);
        JSONObject feature = JSONObject.parseObject(jsonArray.getString(0));
        String properties = feature.getString("properties");
        JSONObject propertiesJSONObject = JSONObject.parseObject(properties);

        StringBuffer sb = new StringBuffer();

        for(int i = 0; i < properties.split(",").length; i++){
            sb.append(new DecimalFormat("##.##").format(Double.parseDouble(propertiesJSONObject.getString("Band" +(i+1)))));
            sb.append(",");
        }

        return sb.toString();
    }


    /**
     * 构建geoserver的wms的一般路径
     * @param workspace
     * @param layer
     * @param pixelX
     * @param pixelY
     * @return
     * @throws Exception
     */
    public String buildPath(String workspace, String layer, String pixelX, String pixelY) throws Exception{

        String spillLayer = workspace + ":" + layer;
        String bbox = "";
        String width = "768";
        String height = "444";
        String x = pixelX;
        String y = pixelY;
        String url = "http://localhost:8080/" +workspace+ "/wms";

        GeoServerRESTReader reader =  new GeoServerRESTReader("http://localhost:8080", "admin", "geoserver");
        RESTLayer restLayer = reader.getLayer(workspace, layer);
        if(restLayer != null){
            try{
                RESTFeatureType restFeatureType = reader.getFeatureType(restLayer);
                double minX = restFeatureType.getMinX();
                double minY = restFeatureType.getMinY();
                double maxX = restFeatureType.getMaxX();
                double maxY = restFeatureType.getMaxY();

                bbox = minX + "," + minY + "," + maxX + "," + maxY;
            }catch (Exception e){
                //TODO
            }
        }
//        BBox bBox = new BBox(73.47709197998049,18.133351135253918,134.8770919799805,53.63335113525392);
//        String bbox  = bBox.getX() + "," + bBox.getY() + "," + bBox.getWidth() + "," + bBox.getHeight();

        String param = "bbox=" + bbox + "&info_format=application/json&format=application/openlayers&request=GetFeatureInfo&" +
                "layers=" + spillLayer + "&query_layers=" + spillLayer + "&width=" + width + "&height=" + height + "&x=" + x + "&y=" + y;
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
//                result += line + ",";
                result += line;
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
