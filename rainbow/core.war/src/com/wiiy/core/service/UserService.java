package com.wiiy.core.service;

import java.util.Set;

import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface UserService extends IService<User> {

	Result<User> login(User user);
	
	Result<User> merge(User user);

	Result<User> updatePassword(User user, String oldPassword, String newPassword);

	Set<UserRoleRef> getUserRoleRefs(Long id);

	Result<?> importCard(String ids);
	Result<?> resetPwd(Long id);
}

