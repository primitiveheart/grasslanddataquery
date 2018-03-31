package com.controller.admin;

import com.alibaba.fastjson.JSONObject;
import com.entity.ApplyData;
import com.entity.User;
import com.mapper.ApplyDataMapper;
import com.mapper.SmallDataTypeMapper;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import com.util.ToolUtils;
import com.vo.ApplyDataVO;
import com.vo.BigSmallDataTypeVo;
import com.vo.DatatableCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
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
    private SmallDataTypeMapper smallDataTypeMapper;


    @RequestMapping(value = "acquireApplyData.html")
    @ResponseBody
    public void acquireApplyData(HttpServletResponse response, @ModelAttribute DatatableCriteria datatableCriteria){
        JSONObject result = new JSONObject();

        Integer recordsTotal = applyDataMapper.applyDataTotalByCondition(datatableCriteria.getSearch().get(DatatableCriteria.SearchCriteria.value));
        Integer recordsFiltered = applyDataMapper.applyDataTotalByCondition(datatableCriteria.getSearch().get(DatatableCriteria.SearchCriteria.value));
        List<ApplyData> page = applyDataMapper.acquiredPageDataByCondition(datatableCriteria.getStart(),
                datatableCriteria.getLength(), datatableCriteria.getSearch().get(DatatableCriteria.SearchCriteria.value));

        //获取所有的小的数据类型
        List<BigSmallDataTypeVo> bigSmallDataTypeVos = smallDataTypeMapper.getAllBigSmallDataType();

        List<ApplyDataVO> data = new ArrayList<ApplyDataVO>();
        for(int i=0; i<page.size(); i++){
            ApplyData applyData = page.get(i);
            User user = userMapper.getUserById(applyData.getUserId());
            ApplyDataVO applyDataVO = new ApplyDataVO(applyData);
            applyDataVO.setUsername(user.getUsername());

            ToolUtils.transferEnglishToChinese(bigSmallDataTypeVos, applyDataVO);

            String coordinate = applyData.getCoordinate();
            applyDataVO.setCoordinate("纬度: " + coordinate.split(";")[1] + " 经度: " + coordinate.split(";")[0]);
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
}
