package com.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by admin on 2018/3/9.
 */
@Controller
@RequestMapping("admin")
public class AdminController {
    @RequestMapping("home.html")
    public String home(){
        return "admin/home";
    }
}
