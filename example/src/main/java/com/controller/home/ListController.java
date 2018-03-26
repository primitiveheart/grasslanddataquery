package com.controller.home;

import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.ServiceDataMapper;
import com.mapper.SmallDataTypeMapper;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import com.util.ToolUtils;
import com.vo.ApplyDataVO;
import com.vo.BigSmallDataTypeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/10/17.
 */
@Controller
@RequestMapping("home")
public class ListController {

    @Autowired
    private ApplyDataMapper applyDataMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ServiceDataMapper serviceDataMapper;

    @Autowired
    private SmallDataTypeMapper smallDataTypeMapper;

    @RequestMapping(value = "acquireApplyData.html")
    @ResponseBody
    public void acquireApplyData(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) Integer draw,
                                 @RequestParam(required = false) Integer start, @RequestParam(required = false)Integer length){
        User existUser = (User) request.getSession().getAttribute("user");
        JSONObject result = new JSONObject();

        Integer recordsTotal = applyDataMapper.applyDataTotalByUserId(existUser.getId());
        Integer recordsFiltered = applyDataMapper.applyDataTotalByUserId(existUser.getId());
        List<ApplyData> page = applyDataMapper.acquiredPageDataByUserId(start, length, existUser.getId());

        //获取所有的小的数据类型
        List<BigSmallDataTypeVo> bigSmallDataTypeVos = smallDataTypeMapper.getAllBigSmallDataType();

        List<ApplyDataVO> data = new ArrayList<ApplyDataVO>();
        for(int i=0; i<page.size(); i++){
            ApplyData applyData = page.get(i);
            ApplyDataVO applyDataVO = new ApplyDataVO(applyData);

            ToolUtils.transferEnglishToChinese(bigSmallDataTypeVos, applyDataVO);

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
     *  地图方式的获取的数据
     * @param request
     * @param type 小的数据类型
     * @return
     */
    @RequestMapping("mapMethod.html")
    public String mapMethod(HttpServletRequest request, String type){

        List<String> allYear = serviceDataMapper.listYearBySmallDataTypeEnglish(type);
        request.setAttribute("allYear", allYear);
        request.setAttribute("type", type);

        return "home/map-method";
    }

    @RequestMapping("lookupResult.html")
    public String lookupResult(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:login.html";
        }else{
            return "home/lookup-result";
        }
    }

    @RequestMapping("deleteApplyData.html")
    public String deleteApplyData(Integer id){
        //删除申请数据
        applyDataMapper.deleteApplyData(id);
        return "home/lookup-result";
    }

}
