package com.wiiy.core.dao;

import com.wiiy.core.entity.User;
import com.wiiy.hibernate.BaseDao;

/**
 * @author my
 */
public class UserDao extends BaseDao<User>{

	/*public User getUserByName(String username) {
		try {
			User user = (User) getSession().createQuery("select u from User as u where u.username=?")
					.setString(0, username).uniqueResult();
			return user;
		} catch (Exception e) {
			return null;
		}
	}*/
	
	
}