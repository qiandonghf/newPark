package com.wiiy.core.external.service;

import java.util.List;

import com.wiiy.core.entity.User;

public interface UserPubService {
	public List<User> getCenterUserList();
	public List<User> getCenterUserList2();//去掉用户状态为禁用的用户
	
}
