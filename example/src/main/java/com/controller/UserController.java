package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.User;
import com.mapper.UserMapper;
import com.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by admin on 2017/10/16.
 */
@Controller
public class UserController {

    @Autowired
    private UserMapper userMapper;

    /**
     * 登录
     * @return
     */
    @RequestMapping("{path}/login.html")
    public String login(HttpServletRequest request, @PathVariable("path") String path){
        return path + "/login";
    }

    /**
     * 登录有效
     * @return
     */
    @RequestMapping(value = "{path}/loginUp.html", method = RequestMethod.POST)
    public String loginUp() throws Exception{
        return "redirect:home.html";
    }

    /**
     * 登录验证
     * @param request
     * @param response
     * @param name
     * @param value
     * @throws Exception
     */
    @RequestMapping(value = "{path}/loginValidation.html",method = RequestMethod.POST)
    @ResponseBody
    public void loginValidation(HttpServletRequest request, HttpServletResponse response, String name,
                                String value, @PathVariable("path") String path) throws Exception{
        JSONObject jsonObject = new JSONObject();
        HttpSession session = request.getSession();

        //调用service进行用户身份验证
        User queryUser = userMapper.getUserByUsername(value);

        if(path.equals("admin")){
            if(queryUser == null){
                //用户名和密码
                User existUser = (User) session.getAttribute("admin");
                if(existUser == null){
                    //用户名不存在
                    jsonObject.put("type", name);
                }else{
                    if(!value.equals(existUser.getPassword())){
                        //用户名存在，但是密码不正确
                        jsonObject.put("type", name);
                    }
                }
            }else{
                if(queryUser.getUserType().equals("0")){
                    session.setAttribute("admin", queryUser);
                }else{
                    //用户不是管理员用户
                    jsonObject.put("type",name);
                }

            }
        }else{
            if(queryUser == null){
                //用户名和密码
                User existUser = (User) session.getAttribute("user");
                if(existUser == null){
                    //用户名不存在
                    jsonObject.put("type", name);
                }else{
                    if(!value.equals(existUser.getPassword())){
                        //用户名存在，但是密码不正确
                        jsonObject.put("type", name);
                    }
                }

            }else{
                session.setAttribute("user", queryUser);
            }
        }

        ResponseUtil.renderJson(response, jsonObject);
    }

    /**
     * 注册
     * @return
     */
    @RequestMapping("{path}/register.html")
    public String register(HttpServletRequest request, @PathVariable("path") String path){
        return path + "/register";
    }

    /**
     * 注册验证
     * @param user
     * @return
     */
    @RequestMapping("{path}/registerValidation.html")
    public String registerValidation(User user, @PathVariable("path") String path){
        User queryUser = userMapper.getUserByUsername(user.getUsername());
        if(queryUser == null){
            user.setUserType("1");
            userMapper.addUser(user);
            return "redirect:login.html";
        }else{
            //用户名存在
            return "redirect:register.html";
        }
    }

    /**
     * 注销
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("{path}/logout.html")
    public String logout(HttpSession session, @PathVariable("path") String path) throws Exception{
        if(path.equals("admin")){
            session.removeAttribute("admin");
        }else {
            session.removeAttribute("user");
        }
        //清除session
//        session.invalidate();
        //重新定向到登录页面
        return "redirect:login.html";
    }

}
