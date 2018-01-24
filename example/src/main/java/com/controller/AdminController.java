package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.User;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by admin on 2018/1/24.
 */
@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private UserMapper userMapper;

    @RequestMapping("login.html")
    public String login(){
        return "admin/login";
    }

    @RequestMapping("home.html")
    public String home(){
        return "admin/home";
    }

    @RequestMapping("logout.html")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:login.html";
    }

    @RequestMapping(value = "loginValidation.html",method = RequestMethod.POST)
    @ResponseBody
    public void loginValidation(HttpServletRequest request, HttpServletResponse response, String name, String value) throws Exception{
        JSONObject jsonObject = new JSONObject();
        HttpSession session = request.getSession();
        //调用service进行用户身份验证
        User queryUser = userMapper.getUserByUsername(value);
        if(queryUser == null){
            //用户不存在
           jsonObject.put("type", name);
        }else if(queryUser.getPassword().equals(value)){
            //在session中保存用户身份信息
            session.setAttribute("user", queryUser);
        }else{
            jsonObject.put("type", name);
        }

        ResponseUtil.renderJson(response, jsonObject);
    }

    @RequestMapping(value = "loginValid.html", method = RequestMethod.POST)
    public String loginValid(HttpSession session, User admin){
        User queryUser = userMapper.getUserByUsername(admin.getUsername());
        if(queryUser == null){
            //用户名不存在
            return "redirect:login.html";
        }else if(admin.getPassword().equals(queryUser.getPassword())){
            session.setAttribute("admin", queryUser);
            return "redirect:home.html";
        }else {
            //密码不正确
            return "redirect:login.html";
        }
    }
}
