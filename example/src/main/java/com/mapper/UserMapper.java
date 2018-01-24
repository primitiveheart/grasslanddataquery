package com.mapper;

import com.entity.User;

import java.util.List;

/**
 * Created by admin on 2017/10/16.
 */
public interface UserMapper {
     void addUser(User user);

     List<User> getAllUser();

    User getUserByUsername(String username);

    void deleteByUsername(String uesrname);

    void update(User user);

}
