package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.ParamDao;
import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.WaterMark;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.ParamService;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ParamServiceImpl implements ParamService{
	private ParamDao paramDao;

	@Override
	public Result<Param> save(Param t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			paramDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的基本参数");
			return Result.success(R.Param.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Param.class)));
		}catch (Exception e) {
			return Result.failure(R.Param.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Param> update(Param t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			paramDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的基本参数");
			return Result.success(R.Param.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Param.class)));
		} catch (Exception e) {
			return Result.failure(R.Param.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Param> delete(Param t) {
		try {
			paramDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的基本参数");
			return Result.success(R.Param.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Param.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Param> deleteById(Serializable id) {
		try {
			paramDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的基本参数");
			return Result.success(R.Param.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Param.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Param> deleteByIds(String ids) {
		try {
			paramDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的基本参数");
			}
			return Result.success(R.Param.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Param.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Param> getBeanByFilter(Filter filter) {
		try {
			return Result.value(paramDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Param.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Param> getBeanById(Serializable id) {
		try {
			return Result.value(paramDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Param.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Param>> getList() {
		try {
			return Result.value(paramDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Param.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Param>> getListByFilter(Filter filter) {
		try {
			return Result.value(paramDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Param.LOAD_FAILURE);
		}
	}

	public void setParamDao(ParamDao paramDao) {
		this.paramDao = paramDao;
	}

	@Override
	public Result<Param> saveOrUpdate(
			Param param,WaterMark waterMark,ContactInfo contactInfo) {
		Session session = null;
		Transaction tr = null;
		try {
			session = paramDao.openSession();
			tr = session.beginTransaction();
			setCreator(param);
			setModifier(param);
			setCreator(waterMark);
			setModifier(waterMark);
			setCreator(contactInfo);
			setModifier(contactInfo);
			session.saveOrUpdate(param);
			waterMark.setParamId(param.getId());
			contactInfo.setParamId(param.getId());
			session.saveOrUpdate(waterMark);
			session.saveOrUpdate(contactInfo);
			tr.commit();
			return Result.success(R.Param.SAVE_SUCCESS, param);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Param.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Param.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	private void setCreator(BaseEntity entity){
		entity.setCreateTime(new Date());
		entity.setCreatorId(CmsActivator.getSessionUser().getId());
		entity.setCreator(CmsActivator.getSessionUser().getRealName());
		entity.setEntityStatus(EntityStatus.NORMAL);
	}
	
	private void setModifier(BaseEntity entity){
		entity.setModifyTime(entity.getCreateTime());
		entity.setModifier(entity.getCreator());
		entity.setModifierId(entity.getCreatorId());
	}

}
