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
    //扩展字段
    private String extras;

    public User(Integer id, String username, String password, String userType, String extras) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.userType = userType;
        this.extras = extras;
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
}
