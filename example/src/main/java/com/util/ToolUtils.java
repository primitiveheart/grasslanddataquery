package com.util;

import com.constant.TypeConstant;
import com.vo.ApplyDataVO;
import com.vo.BigSmallDataTypeVo;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.SystemUtils;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/10/14.
 */
public class ToolUtils {

    public static DecimalFormat df = new DecimalFormat("######0.00");

    public static String getTemp(String tempature){
        String[] str = tempature.split("--------------------------------------------");
        String[] band = null;
        if(str.length > 1 && StringUtils.isNotEmpty(str[1])){
            String[] middle = str[1].split(",");
            band = new String[middle.length-1];
            for(int i = 1; i < middle.length; i++){
                band[i-1] = df.format(Double.valueOf(middle[i].split("=")[1]));
            }
        }
        StringBuffer sb = new StringBuffer();
        for(int i = 0;i < band.length ; i++){
            sb.append(band[i]);
            sb.append(",");
        }
        return sb.toString();
    }

    public static void transferEnglishToChinese(List<BigSmallDataTypeVo> bigSmallDataTypeVos, ApplyDataVO applyDataVO) {
        for(BigSmallDataTypeVo bigSmallDataTypeVo : bigSmallDataTypeVos){
            //把大数据类型的英文替换成大数据类型的中文
            if(applyDataVO.getDataType().contains(bigSmallDataTypeVo.getbDataTypeEnglish())){
                applyDataVO.setDataType(applyDataVO.getDataType()
                        .replace(bigSmallDataTypeVo.getbDataTypeEnglish(), bigSmallDataTypeVo.getbDataType())
                        .replaceAll("\"", "").replaceAll("," , " ").replaceAll("\\{","").replaceAll("\\}", "")
                        .replaceAll("\\[", "").replaceAll("\\]", ""));
            }
            //把小数据类型的英文替换成小数据类型的中文
            if(applyDataVO.getDataType().contains(bigSmallDataTypeVo.getsDataTypeEnglish())){
                applyDataVO.setDataType(applyDataVO.getDataType()
                        .replace(bigSmallDataTypeVo.getsDataTypeEnglish(), bigSmallDataTypeVo.getsDataType())
                        .replaceAll("\"", "").replaceAll("," , " ").replaceAll("\\{","").replaceAll("\\}", "")
                        .replaceAll("\\[", "").replaceAll("\\]", ""));
            }
        }
    }

    /**
     * 得到json的类型：数组和json对象
     * @param jsonStr
     * @return
     */
    public static JSONType getJSONType(String jsonStr){
        if(jsonStr == null || StringUtils.isEmpty(jsonStr)){
            return JSONType.JSON_TYPE_EEROR;
        }
        char[] strChar = jsonStr.substring(0, 1).toCharArray();
        char firstChar = strChar[0];

        if (firstChar == '{') {
            return JSONType.JSON_TYPE_OBJECT;
        }else if(firstChar == '['){
            return JSONType.JSON_TYPE_ARRAY;
        }else {
            return JSONType.JSON_TYPE_EEROR;
        }
    }

    public static void main(String[] args){
        String temp = "Results for FeatureType 'http://localhost:8070/cite:geotools_coverage_3',--------------------------------------------,Band1 = -8.496833801269531,Band2 = -4.083225250244141," +
        "Band3 = 5.937929153442383,Band4 = 15.22526741027832,Band5 = 22.45359992980957,Band6 = 24.122669219970703,Band7 = 27.04982566833496,Band8 = 24.605207443237305,Band9 = 19.084739685058594," +
        "Band10 = 8.31626033782959,Band11 = -0.3518502712249756,Band12 = -5.569386959075928,--------------------------------------------";
        String result = getTemp(temp);
        System.out.println(result);
    }
}
