package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.InitializingBean;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.RoleAuthorityRefDao;
import com.wiiy.core.dao.RoleDao;
import com.wiiy.core.dto.AuthorityDto;
import com.wiiy.core.dto.ModuleAuthorityDto;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.export.RoleAuthorityRefService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class RoleAuthorityRefServiceImpl implements RoleAuthorityRefService, InitializingBean {
	
	private RoleAuthorityRefDao roleAuthorityRefDao;
	
	private RoleDao roleDao;
	
	private Map<Long, Set<String>> roleAuthorityRefMap;

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public void setRoleAuthorityRefDao(RoleAuthorityRefDao roleAuthorityRefDao) {
		this.roleAuthorityRefDao = roleAuthorityRefDao;
	}

	@Override
	public Result<RoleAuthorityRef> save(RoleAuthorityRef t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roleAuthorityRefDao.save(t);
			return Result.success(R.RoleAuthorityRef.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoleAuthorityRef.class)));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> delete(RoleAuthorityRef t) {
		try {
			roleAuthorityRefDao.delete(t);
			return Result.success(R.RoleAuthorityRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> deleteById(Serializable id) {
		try {
			roleAuthorityRefDao.deleteById(id);
			return Result.success(R.RoleAuthorityRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> deleteByIds(String ids) {
		try {
			roleAuthorityRefDao.deleteByIds(ids);
			return Result.success(R.RoleAuthorityRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> update(RoleAuthorityRef t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			roleAuthorityRefDao.update(t);
			return Result.success(R.RoleAuthorityRef.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoleAuthorityRef.class)));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> getBeanById(Serializable id) {
		try {
			return Result.value(roleAuthorityRefDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoleAuthorityRef> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roleAuthorityRefDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoleAuthorityRef>> getList() {
		try {
			return Result.value(roleAuthorityRefDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoleAuthorityRef>> getListByFilter(Filter filter) {
		try {
			return Result.value(roleAuthorityRefDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoleAuthorityRef.LOAD_FAILURE);
		}
	}

	@Override
	public Map<Long, Set<String>> getRoleAuthorityRefMap() {
		// TODO Auto-generated method stub
		return roleAuthorityRefMap;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		
		roleAuthorityRefMap = new HashMap<Long, Set<String>>();
		
		List<RoleAuthorityRef> allRoleAuthorityRefs = roleAuthorityRefDao.getList();
		
		for (RoleAuthorityRef roleAuthorityRef : allRoleAuthorityRefs) {
			
			Long roleId = roleAuthorityRef.getRole().getId();
			
			Set<String> authorityGlobalIds = roleAuthorityRefMap.get(roleId);
			
			if (authorityGlobalIds == null) {
				authorityGlobalIds = new HashSet<String>();
				roleAuthorityRefMap.put(roleId, authorityGlobalIds);
			}
			
			authorityGlobalIds.add(
					roleAuthorityRef.getModuleId() + "_" + roleAuthorityRef.getAuthorityId());
		}
	}

	@Override
	public Result<Role> saveAuthorityRefs(Long roleId, ResourceDto[] moduleAuthorities) {
		
		try {
			roleDao.cleanAuthoritiesInModule(roleId,0L);
			List<RoleAuthorityRef> authorityRefsInModlue = new ArrayList<RoleAuthorityRef>();
			
			for (ResourceDto moduleAuthorityDto : moduleAuthorities) {
				RoleAuthorityRef roleAuthorityRef = new RoleAuthorityRef(roleId, 0+"", moduleAuthorityDto.getIdSpace(), moduleAuthorityDto.getType());
				authorityRefsInModlue.add(roleAuthorityRef);
			}
			roleDao.saveAuthoritiesInModule(authorityRefsInModlue);
			return Result.value(roleDao.getBeanById(roleId));
			
		} catch (Exception e) {
			
			return Result.failure(R.Role.UPDATE_FAILURE);
		}
	}

	/*private List<RoleAuthorityRef> populateRoleAuthorityRefs(
			Long roleId, ResourceDto moduleAuthorityDto) {
		
		List<RoleAuthorityRef> ret = new ArrayList<RoleAuthorityRef>();
		String moduleId = moduleAuthorityDto.getIdSpace();
		for (AuthorityDto authorityDto : moduleAuthorityDto.getAuthorityRefs()) {
			ret.add(new RoleAuthorityRef(roleId, moduleId, authorityDto.getAuthorityId(), authorityDto.getAuthorityType()));
		}
		return ret;
	}*/

	@Override
	public Result<Role> refreshAuthorityRefs(Long id) {
		List<RoleAuthorityRef> roleAuthorityRefs = roleAuthorityRefDao.getListByFilter(new Filter(RoleAuthorityRef.class).createAlias("role", "role").eq("role.id", id));
		Set<String> authorityGlobalIds = new HashSet<String>();
		for (RoleAuthorityRef roleAuthorityRef : roleAuthorityRefs) {
			authorityGlobalIds.add(
					roleAuthorityRef.getModuleId() + "_" + roleAuthorityRef.getAuthorityId());
		}
		roleAuthorityRefMap.put(id, authorityGlobalIds);
		return Result.success();
	}
}
