package com.controller;

import com.entity.User;
import com.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
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
    @RequestMapping("login.html")
    public String login(HttpServletRequest request, @RequestParam(required = false) String userErrorMsg, @RequestParam(required = false) String psdErrorMsg){
        request.setAttribute("userErrorMsg", userErrorMsg);
        request.setAttribute("psdErrorMsg", psdErrorMsg);
        return "login";
    }



    /**
     * 注册
     * @return
     */
    @RequestMapping("register.html")
    public String register(HttpServletRequest request, @RequestParam(required = false) String errorMsg){
        request.setAttribute("errorMsg", errorMsg);
        return "register";
    }

    /**
     * 注册验证
     * @param user
     * @return
     */
    @RequestMapping("registerValidation.html")
    public String registerValidation(User user){
        User queryUser = userMapper.getUserByUsername(user.getUsername());
        if(queryUser == null){
            user.setUserType("1");
            userMapper.addUser(user);
            return "redirect:login.html";
        }else{
            //用户名存在
            String errorMsg = "用户名存在";
            return "redirect:register.html?errorMsg="+ errorMsg;
        }
    }

    /**
     * 登录验证
     * @param session
     * @param user
     * @return
     */
    @RequestMapping(value = "loginValidation.html",method = RequestMethod.GET)
    public String loginValidation(HttpSession session, User user) throws Exception{
        //调用service进行用户身份验证
        User queryUser = userMapper.getUserByUsername(user.getUsername());
        if(queryUser == null){
            //用户不存在
            String userErrorMsg = "用户不存在";
            return "redirect:login.html?userErrorMsg=" + userErrorMsg;
        }else if(queryUser.getPassword().equals(user.getPassword())){
            //在session中保存用户身份信息
            session.setAttribute("user", queryUser);
            //重新定向到住页面
            return "redirect:home.html";
        }else{
            //密码不正确
            String psdErrorMsg = "密码不正确";
            return "redirect:login.html?psdErrorMsg=" + psdErrorMsg;
        }
    }

    /**
     * 注销
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("logout.html")
    public String logout(HttpSession session) throws Exception{
        //清除session
        session.invalidate();
        //重新定向到登录页面
        return "redirect:login.html";
    }

}
