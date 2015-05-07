package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SalaryDefineDao;
import com.wiiy.oa.entity.SalaryDefine;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SalaryDefineService;

public class SalaryDefineServiceImpl implements SalaryDefineService{
	private SalaryDefineDao salaryDefineDao;
	public void setSalaryDefineDao(SalaryDefineDao salaryDefineDao) {
		this.salaryDefineDao = salaryDefineDao;
	}

	@Override
	public Result<SalaryDefine> save(SalaryDefine t) {
		Session session = null;
		Transaction tr = null;
		String salaryDefineName = t.getName();
		String salaryDefineSerialNo = t.getSerialNo();
		try {
			session = salaryDefineDao.openSession();
			tr = session.beginTransaction();
			List<SalaryDefine> salaryDefineList = new ArrayList<SalaryDefine>();
			salaryDefineList = session.createQuery("from SalaryDefine").list();
			for (SalaryDefine salaryDefine : salaryDefineList) {
				if(salaryDefineSerialNo.equals(salaryDefine.getSerialNo())){
					return Result.failure("该编号已存在，请换个编号",salaryDefine);
				}
				if(salaryDefineName.equals(salaryDefine.getName())){
					return Result.failure("该标准名称已存在，请换个名称");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			salaryDefineDao.save(t);
			OaActivator.getOperationLogService().logOP("添加薪资标准【"+t.getName()+"】");
			tr.commit();
			return Result.success(R.SalaryDefine.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryDefine.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SalaryDefine.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<SalaryDefine> update(SalaryDefine t) {
		try {
			List<SalaryDefine> salaryDefines = salaryDefineDao.getListByFilter(new Filter(SalaryDefine.class).eq("serialNo", t.getSerialNo()).ne("id", t.getId()));
			if(salaryDefines.size()>0){
				return Result.failure("标准编号已存在，请换个标准编号");
			}
			List<SalaryDefine> salaryDefines2 = salaryDefineDao.getListByFilter(new Filter(SalaryDefine.class).eq("name", t.getName()).ne("id", t.getId()));
			if(salaryDefines2.size()>0){
				return Result.failure("标准名称已存在，请换个标准名称");
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			salaryDefineDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑薪资标准【"+t.getName()+"】");
			return Result.success(R.SalaryDefine.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryDefine.class)));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.UPDATE_FAILURE);
		}
	}
	@Override
	public Result<SalaryDefine> delete(SalaryDefine t) {
		try {
			salaryDefineDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除薪资标准【"+t.getName()+"】");
			return Result.success(R.SalaryDefine.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefine> deleteById(Serializable id) {
		try {			
			salaryDefineDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资标准");
			return Result.success(R.SalaryDefine.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefine> deleteByIds(String ids) {
		try {			
			salaryDefineDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资标准");
			}
			return Result.success(R.SalaryDefine.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefine> getBeanById(Serializable id) {
		try {
			return Result.value(salaryDefineDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SalaryDefine> getBeanByFilter(Filter filter) {
		try {
			return Result.value(salaryDefineDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryDefine>> getList() {
		try {
			return Result.value(salaryDefineDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryDefine>> getListByFilter(Filter filter) {
		try {
			return Result.value(salaryDefineDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryDefine.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<String> generateCode() {
		String code = "标准"+CalendarUtil.now().get(Calendar.YEAR);
		int count = salaryDefineDao.getRowCount(new Filter(SalaryDefine.class).ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumIntegerDigits(6);
		code = code + nf.format(count+1);
		return Result.value(code);
	}
	
}
