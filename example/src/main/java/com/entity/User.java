package com.entity;

import java.io.Serializable;

/**
 * create table users(
 username varchar(30) primary key,
 password varchar(15) not null,
 userType char(2),
 extras varchar(100)
 )
 * Created by admin on 2017/10/16.
 */
public class User implements Serializable{
    private Integer id;
    //用户名（唯一）
    private String username;
    //密码
    private String password;
    //是否是普通用户还是管理员,0表示管理员,1表示普通用户
    private String userType;
    //邮箱
    private String email;
    //电话号码
    private String mobilephone;
    //昵称
    private String nickname;
    //扩展字段
    private String extras;

    public User(Integer id, String username, String password, String userType,
                String extras, String email, String mobilephone, String nickname) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.userType = userType;
        this.extras = extras;
        this.mobilephone = mobilephone;
        this.email = email;
        this.nickname = nickname;
    }

    public User(){}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getExtras() {
        return extras;
    }

    public void setExtras(String extras) {
        this.extras = extras;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobilephone() {
        return mobilephone;
    }

    public void setMobilephone(String mobilephone) {
        this.mobilephone = mobilephone;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
