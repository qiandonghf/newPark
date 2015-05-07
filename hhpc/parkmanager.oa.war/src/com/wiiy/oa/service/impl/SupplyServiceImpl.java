package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SupplyCategoryDao;
import com.wiiy.oa.dao.SupplyDao;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyCategory;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SupplyService;

public class SupplyServiceImpl implements SupplyService {

	private SupplyDao supplyDao;
	private SupplyCategoryDao supplyCategoryDao;

	public void setSupplyDao(SupplyDao supplyDao) {
		this.supplyDao = supplyDao;
	}

	@Override
	public Result<Supply> save(Supply t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			String categoryIds = ",";
			t.getCategory().setId(t.getCategoryId());
			if(t.getCategoryId()!=null){
				categoryIds = addCategoryIds(categoryIds, t.getCategoryId());
			}
			t.setCategoryIds(categoryIds);
			supplyDao.save(t);
			OaActivator.getOperationLogService().logOP("添加办公用品【"+t.getName()+"】");
			return Result.success(R.Supply.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Supply.class)));
		} catch (Exception e) {
			return Result.failure(R.Supply.SAVE_FAILURE);
		}
	}
	
	public String addCategoryIds(String categoryIds,Long id){
		SupplyCategory supplyCategory = supplyCategoryDao.getBeanById(id);
		if(!supplyCategory.getParentIds().equals(",")){
			categoryIds = supplyCategory.getParentIds()+id+",";
		}else{
			categoryIds = ","+id+",";
		}
		return categoryIds;
	}
	
	@Override
	public Result<Supply> update(Supply t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			supplyDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑办公用品【"+t.getName()+"】");
			return Result.success(R.Supply.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Supply.class)));
		} catch (Exception e) {
			return Result.failure(R.Supply.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<Supply> delete(Supply t) {
		try {
			supplyDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除办公用品【"+t.getName()+"】");
			return Result.success(R.Supply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Supply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Supply> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的办公用品");
			supplyDao.deleteById(id);
			return Result.success(R.Supply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Supply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Supply> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的办公用品");
			}
			supplyDao.deleteByIds(ids);
			return Result.success(R.Supply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Supply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Supply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(supplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Supply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Supply> getBeanById(Serializable id) {
		try {
			return Result.value(supplyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Supply.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<List<Supply>> getList() {
		try {
			return Result.value(supplyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Supply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Supply>> getListByFilter(Filter filter) {
		try {
			return Result.value(supplyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Supply.LOAD_FAILURE);
		}
	}

	public SupplyCategoryDao getSupplyCategoryDao() {
		return supplyCategoryDao;
	}

	public void setSupplyCategoryDao(SupplyCategoryDao supplyCategoryDao) {
		this.supplyCategoryDao = supplyCategoryDao;
	}
	
}
