package com.wiiy.core.service.impl;

import java.io.Serializable;
import java.util.List;

import com.wiiy.core.dao.OrgDao;
import com.wiiy.core.entity.Org;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.OrgService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class OrgServiceImpl implements OrgService {
	
	private OrgDao orgDao;
	
	public void setOrgDao(OrgDao orgDao) {
		this.orgDao = orgDao;
	}

	@Override
	public Result<Org> save(Org t) {
		try {
			orgDao.save(t);
			return Result.success(R.Org.SAVE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Org.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Org> delete(Org t) {
		try {
			orgDao.delete(t);
			return Result.success(R.Org.DELETE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Org.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Org> deleteById(Serializable id) {
		try {
	        Org toDeleteOrg = orgDao.getBeanById(id);
	        Org parent = toDeleteOrg.getParent();
	        if(parent!=null){
	        	parent.removeChild();
	        	orgDao.update(parent);
	        	orgDao.updateSiblingOrder(toDeleteOrg, -1);
	        }
	        orgDao.deleteById(id);
			return Result.success(R.Org.DELETE_SUCCESS, toDeleteOrg);
		} catch (Exception e) {
			return Result.failure(R.Org.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Org> deleteByIds(String ids) {
		try {
			orgDao.deleteByIds(ids);
			return Result.success(R.Org.DELETE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Org.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Org> update(Org t) {
		try {
			orgDao.update(t);
			return Result.success(R.Org.UPDATE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Org.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Org> getBeanById(Serializable id) {
		try {
			Org org = orgDao.getBeanById(id);
			return Result.value(org);
		} catch (Exception e) {
			return Result.failure(R.Org.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Org> getBeanByFilter(Filter filter) {
		try {
			Org org = orgDao.getBeanByFilter(filter);
			return Result.value(org);
		} catch (Exception e) {
			return Result.failure(R.Org.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Org>> getList() {
		try {
			List<Org> orgList = orgDao.getList();
			return Result.value(orgList);
		} catch (Exception e) {
			return Result.failure(R.Org.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Org>> getListByFilter(Filter filter) {
		try {
			List<Org> orgList = orgDao.getListByFilter(filter);
			return Result.value(orgList);
		} catch (Exception e) {
			return Result.failure(R.Org.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Org>> getOrgTree() {
		try {
			List<Org> orgList = orgDao.listByPathCode();
			return Result.value(orgList);
		} catch (Exception e) {
			return Result.failure(R.Org.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Org> saveOrUpdateOrg(Org org) {
        if (org.isNew()) {
        	try {
        		if (orgDao.getBeanByFilter(new Filter(Org.class).eq("name", org.getName()))!=null) {
        			return Result.failure(R.Org.SAVE_FAILURE_DUPLICATED_NAME);
        		}
        		
                Org parent = orgDao.getBeanById(org.getParent().getId());
                parent.addChild();
                orgDao.update(parent);
                org.setLevelCode(parent.getLevelCode() + 1);
                org.setOrderCode(org.getOrderCode() + parent.getChildrenCount()-1);
                org.setPathCode(parent.getPathCode() + "," + org.getOrderCode());
                orgDao.save(org);
                return Result.value(org);
    		} catch (Exception e) {
    			return Result.failure(R.Org.SAVE_FAILURE);
    		}

        } else {

        	try {
        		if (orgDao.getBeanByFilter(new Filter(Org.class).ne("id", org.getId()).eq("name", org.getName()))!=null) {
        			return Result.failure(R.Org.SAVE_FAILURE_DUPLICATED_NAME);
        		}

        		Org dbOrg = orgDao.getBeanById(org.getId());
	            dbOrg.setName(org.getName());
	            dbOrg.setEntityStatus(org.getEntityStatus());
	            dbOrg.setMemo(org.getMemo());
	            orgDao.update(dbOrg);
	
	            return Result.value(org);
    		} catch (Exception e) {
    			return Result.failure(R.Org.UPDATE_FAILURE);
    		}
        }
	}

}
