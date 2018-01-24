package com.util;

import com.alibaba.fastjson.JSONObject;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * Created by admin on 2017/10/15.
 */
public class ResponseUtil {
    public static void renderJson(HttpServletResponse response, String jsonStr){
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out = null;
        try{
            out = response.getWriter();
            out.append(jsonStr);
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            if(out != null){
                out.close();
            }
        }
    }

    public static void renderJson(HttpServletResponse response , JSONObject jsonObject){
        renderJson(response, jsonObject.toJSONString());
    }
}
