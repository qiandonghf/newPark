package com.wiiy.crm.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.dao.ContectInfoDao;
import com.wiiy.crm.entity.ContectInfo;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.ContectInfoService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ContectInfoServiceImpl implements ContectInfoService{
	
	private ContectInfoDao contectInfoDao;
	
	public void setContectInfoDao(ContectInfoDao contectInfoDao) {
		this.contectInfoDao = contectInfoDao;
	}

	@Override
	public Result<ContectInfo> save(ContectInfo t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contectInfoDao.save(t);
			PbActivator.getOperationLogService().logOP("新建交往信息【"+t.getContent()+"】");
			return Result.success(R.ContectInfo.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContectInfo.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> delete(ContectInfo t) {
		try {
			PbActivator.getOperationLogService().logOP("删除交往信息【"+t.getContent()+"】");
			contectInfoDao.delete(t);
			return Result.success(R.ContectInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> deleteById(Serializable id) {
		try {
			contectInfoDao.deleteById(id);
			PbActivator.getOperationLogService().logOP("删除交往信息:id为【"+id+"】");
			return Result.success(R.ContectInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> deleteByIds(String ids) {
		try {
			contectInfoDao.deleteByIds(ids);
			PbActivator.getOperationLogService().logOP("删除交往信息:ids为【"+ids+"】");
			return Result.success(R.ContectInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> update(ContectInfo t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contectInfoDao.update(t);
			PbActivator.getOperationLogService().logOP("更新交往信息【"+t.getContent()+"】");
			return Result.success(R.ContectInfo.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContectInfo.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> getBeanById(Serializable id) {
		try {
			return Result.value(contectInfoDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContectInfo> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contectInfoDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContectInfo>> getList() {
		try {
			return Result.value(contectInfoDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContectInfo>> getListByFilter(Filter filter) {
		try {
			return Result.value(contectInfoDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ContectInfo.LOAD_FAILURE);
		}
	}
	
}
