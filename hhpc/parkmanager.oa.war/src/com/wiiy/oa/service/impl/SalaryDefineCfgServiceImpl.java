package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SalaryDefineCfgDao;
import com.wiiy.oa.entity.SalaryDefineCfg;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SalaryDefineCfgService;

public class SalaryDefineCfgServiceImpl implements SalaryDefineCfgService{
	private SalaryDefineCfgDao salaryDefineCfgDao;
	public void setSalaryDefineCfgDao(SalaryDefineCfgDao salaryDefineCfgDao) {
		this.salaryDefineCfgDao = salaryDefineCfgDao;
	}
	
	@Override
	public Result save2(String ids,Long salaryDefineId) {
		try {	
			if(ids!=null){
				Long[] idArray = StringUtil.splitToLongArray(ids);
				for (Long salaryItemId : idArray) {
					SalaryDefineCfg t = new SalaryDefineCfg();					
					t.setSalaryDefineId(salaryDefineId);
					t.setSalaryItemId(salaryItemId);								
					t.setCreateTime(new Date());
					t.setCreator(OaActivator.getSessionUser().getRealName());
					t.setCreatorId(OaActivator.getSessionUser().getId());
					t.setModifyTime(t.getCreateTime());
					t.setModifier(t.getCreator());
					t.setModifierId(t.getCreatorId());
					t.setEntityStatus(EntityStatus.NORMAL);
					salaryDefineCfgDao.save(t);
					OaActivator.getOperationLogService().logOP("添加标准编号为【"+t.getSalaryDefineId()+"】的薪资标准配置");
				}				
			}
			return Result.success(R.SalaryDefineCfg.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryDefineCfg.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.SalaryDefineCfg.SAVE_FAILURE);
		}
	}
	
	@Override
	public Result<SalaryDefineCfg> save(SalaryDefineCfg t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			salaryDefineCfgDao.save(t);
			OaActivator.getOperationLogService().logOP("添加标准编号为【"+t.getSalaryDefineId()+"】的薪资标准配置");
			return Result.success(R.SalaryDefineCfg.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryDefineCfg.class)));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> delete(SalaryDefineCfg t) {
		try {
			salaryDefineCfgDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除标准编号为【"+t.getSalaryDefineId()+"】的薪资标准配置");
			return Result.success(R.SalaryDefineCfg.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资标准配置");
			salaryDefineCfgDao.deleteById(id);
			return Result.success(R.SalaryDefineCfg.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资标准配置");
			}
			salaryDefineCfgDao.deleteByIds(ids);
			return Result.success(R.SalaryDefineCfg.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> update(SalaryDefineCfg t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			salaryDefineCfgDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】薪资标准配置");
			return Result.success(R.SalaryDefineCfg.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryDefineCfg.class)));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> getBeanById(Serializable id) {
		try {
			return Result.value(salaryDefineCfgDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefineCfg> getBeanByFilter(Filter filter) {
		try {
			return Result.value(salaryDefineCfgDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryDefineCfg>> getList() {
		try {
			return Result.value(salaryDefineCfgDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryDefineCfg>> getListByFilter(Filter filter) {
		try {
			return Result.value(salaryDefineCfgDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefineCfg.LOAD_FAILURE);
		}
	}
	
}
