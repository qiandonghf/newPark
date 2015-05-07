package com.wiiy.external.service.test;

import java.util.List;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;

public class UserPubServiceTest {
	public void Test(){
		UserPubService userPubService=CoreActivator.getService(UserPubService.class);
		List<User> centerUserList=userPubService.getCenterUserList();
		System.out.println("LoginAction.login():centerUserList:"+centerUserList.size());
	}
}
