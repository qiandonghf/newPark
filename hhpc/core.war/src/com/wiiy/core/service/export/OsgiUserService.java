package com.wiiy.core.service.export;

import java.util.List;
import java.util.Set;

import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.hibernate.Result;

public interface OsgiUserService {
	
	public User getById(Long id);
	public Result<User> createUser(User user);
	public Result<User> updateUser(Long id , String password);
	public List<User> getUsersByIds(String[] ids);
	public Set<UserRoleRef> getUserRoleRefById(Long id);
	public User getByHql(String hql);
}
