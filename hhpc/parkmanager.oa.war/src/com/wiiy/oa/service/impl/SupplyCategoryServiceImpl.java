package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SupplyCategoryDao;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.entity.SupplyCategory;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SupplyCategoryService;

public class SupplyCategoryServiceImpl implements SupplyCategoryService{
	private SupplyCategoryDao supplyCategoryDao;
	private int level = 0;
	
	public void setSupplyCategoryDao(SupplyCategoryDao supplyCategoryDao) {
		this.supplyCategoryDao = supplyCategoryDao;
	}

	@Override
	public Result<SupplyCategory> save(SupplyCategory t) {
		try {
			if(t.getParentId()!=null){
				List<SupplyCategory> supplyCaList = getListByFilter(new Filter(SupplyCategory.class).eq("parentId", t.getParentId()).eq("name", t.getName())).getValue();
				if(supplyCaList!=null && supplyCaList.size()>0){
					return Result.failure("该类型已经存在");
				}
				SupplyCategory supplyCategory = getBeanByFilter(new Filter(SupplyCategory.class).eq("id", t.getParentId())).getValue();
				t.setLevel(supplyCategory.getLevel()+1);
			}else{
				List<SupplyCategory> supplyCaList = getListByFilter(new Filter(SupplyCategory.class).isNull("parentId").eq("name", t.getName())).getValue();
				if(supplyCaList!=null && supplyCaList.size()>0){
					return Result.failure("该类型已经存在");
				}
				t.setLevel(level);
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds, t.getParentId());
			}
			t.setParentIds(parentIds);
			supplyCategoryDao.save(t);
			OaActivator.getOperationLogService().logOP("添加办公用品类型【"+t.getName()+"】");
			return Result.success(R.SupplyCategory.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.SAVE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		SupplyCategory supplyCategory = supplyCategoryDao.getBeanById(id);
		if(!supplyCategory.getParentIds().equals(",")){
			parentIds = supplyCategory.getParentIds()+id+",";
		}else{
			parentIds = ","+id+",";
		}
		return parentIds;
	}

	@Override
	public Result<SupplyCategory> delete(SupplyCategory t) {
		try {
			OaActivator.getOperationLogService().logOP("删除办公用品类型【"+t.getName()+"】");
			supplyCategoryDao.delete(t);
			return Result.success(R.SupplyCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyCategory> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的办公用品类型");
			supplyCategoryDao.deleteById(id);
			return Result.success(R.SupplyCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyCategory> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的办公用品类型");
			}
			supplyCategoryDao.deleteById(ids);
			return Result.success(R.SupplyCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyCategory> update(SupplyCategory t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			supplyCategoryDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑办公用品类型【"+t.getName()+"】");
			return Result.success(R.SupplyCategory.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SupplyCategory> getBeanById(Serializable id) {
		try {
			return Result.value(supplyCategoryDao.getBeanById(id));
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyCategory> getBeanByFilter(Filter filter) {
		try {
			return Result.value(supplyCategoryDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyCategory>> getList() {
		try {
			return Result.value(supplyCategoryDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyCategory>> getListByFilter(Filter filter) {
		try {
			return Result.value(supplyCategoryDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyCategory.LOAD_FAILURE);
		}
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
	
}
