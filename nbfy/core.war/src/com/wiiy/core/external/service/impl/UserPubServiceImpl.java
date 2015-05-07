package com.wiiy.core.external.service.impl;

import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.dao.UserDao;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;

public class UserPubServiceImpl implements UserPubService {

	private UserDao userDao;
	
	
	@Override
	public List<User> getCenterUserList() {
		return userDao.getListByHql("from User where userType='"+UserTypeEnum.Center.name()+"'");
	}



	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}



	@Override
	public List<User> getCenterUserList2() {
		return userDao.getListByHql("from User where userType='"+UserTypeEnum.Center.name()+"'"+"and entityStatus='"+EntityStatus.NORMAL+"'");
	}

}
