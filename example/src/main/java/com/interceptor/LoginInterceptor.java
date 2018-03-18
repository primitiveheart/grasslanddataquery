package com.interceptor;

import com.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by admin on 2017/10/16.
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 进行Handler方法之前执行
     * 进行身份认证、身份授权
     * 比如身份认证，如果认证不通过表示当前用户没有登，需要此方法拦截不再向下执行
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取请求url
        String url = request.getRequestURI();
        //判断url是否是公开地址（实际使用使将公开地址配置在配置文件中）
        //这里公开地址是登陆提交和注册提交的地址
        if(url.indexOf("login.html") >= 0 || url.indexOf("register.html") >= 0 || url.indexOf("loginValidation.html") >= 0 || url.indexOf("registerValidation.html") >= 0){
            //如果进行登陆提交和注册提交放行，放行
            return true;
        }
        //判断session
        HttpSession session = request.getSession();
        //从session中取出身份信息


        if(url.contains("admin")){
            User user = (User) session.getAttribute("admin");
            if(user != null){
                if(user.getUserType().equals("0")){
                    //身份存在，放行
                    return true;
                }
            }
        }else{
            User user = (User) session.getAttribute("user");
           if(user != null){
               if(user.getUserType().equals("1")){
                   //身份存在，放行
                   return true;
               }
           }
        }

        //执行到这里表示用户身份需要认证，跳转到登录页面
        request.getRequestDispatcher("login.html").forward(request, response);

        //return false表示拦截，不再向下执行
        //return true表示方向
        return false;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
