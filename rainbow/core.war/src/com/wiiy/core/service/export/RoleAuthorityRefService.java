package com.wiiy.core.service.export;

import java.util.Map;
import java.util.Set;

import com.wiiy.commons.service.IService;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface RoleAuthorityRefService extends IService<RoleAuthorityRef> {
	
	Map<Long, Set<String>> getRoleAuthorityRefMap();

	Result<Role> saveAuthorityRefs(Long id,
			ResourceDto[] moduleAuthorities);

	Result<Role> refreshAuthorityRefs(Long id);
}
