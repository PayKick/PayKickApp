package com.epam.javalab13.service.game;

import com.epam.javalab13.dao.UserDAO;
import com.epam.javalab13.model.User;

import java.sql.SQLException;

/**
 * Created by Olga on 05.09.2016.
 */
public class UserService {
    UserDAO userDAO=new UserDAO();

    public void addUser(User user) throws SQLException {
        userDAO.addUser(user);
    }

    public User findUserByLoginAndPassword(String login, String password) throws SQLException {
        return userDAO.findUserByLoginAndPassword(login, password);
    }
}