package com.wiiy.core.service;

import java.util.List;
import java.util.Set;

//import com.wiiy.commons.service.IService;
import com.wiiy.commons.service.IService;
import com.wiiy.core.dto.ModuleAuthorityDto;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.hibernate.Result;

public interface RoleService extends IService<Role> {
	
	List<Role> getByUserRef(Long userId);

	Result<Role> submitConfigRoleDesktop(Long id, String ids, String orderIds);

}

