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
import com.wiiy.oa.dao.AssetsDepreciationDao;
import com.wiiy.oa.entity.AssetsDepreciation;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.AssetsDepreciationService;

public class AssetsDepreciationServiceImpl implements AssetsDepreciationService{
	private AssetsDepreciationDao assetsDepreciationDao;	
	public void setAssetsDepreciationDao(AssetsDepreciationDao assetsDepreciationDao) {
		this.assetsDepreciationDao = assetsDepreciationDao;
	}
	@Override
	public Result<AssetsDepreciation> save(AssetsDepreciation t) {		
		try{		
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			assetsDepreciationDao.save(t);		
			OaActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的折旧记录");
			return Result.success(R.AssetsDepreciation.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), AssetsDepreciation.class)));
		}catch(Exception e){
			return Result.failure(R.AssetsDepreciation.SAVE_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> delete(AssetsDepreciation t) {
		try{
			assetsDepreciationDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除所有折旧记录");
			return Result.success(R.AssetsDepreciation.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));			
		}catch(Exception e){
			return Result.failure(R.AssetsDepreciation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> deleteById(Serializable id) {
		try {
			assetsDepreciationDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的折旧记录");
			return Result.success(R.AssetsDepreciation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> deleteByIds(String ids) {
		try {
			assetsDepreciationDao.deleteByIds(ids);
			OaActivator.getOperationLogService().logOP("删除ids为【"+ids+"】的折旧记录");
			return Result.success(R.AssetsDepreciation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> update(AssetsDepreciation t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			assetsDepreciationDao.update(t);
			OaActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的折旧记录");
			return Result.success(R.AssetsDepreciation.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),AssetsDepreciation.class)));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> getBeanById(Serializable id) {
		try {
			return Result.value(assetsDepreciationDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<AssetsDepreciation> getBeanByFilter(Filter filter) {
		try {
			return Result.value(assetsDepreciationDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<AssetsDepreciation>> getList() {
		try {
			return Result.value(assetsDepreciationDao.getList());
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<AssetsDepreciation>> getListByFilter(Filter filter) {
		try {
			return Result.value(assetsDepreciationDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.AssetsDepreciation.LOAD_FAILURE);
		}
	}
}
