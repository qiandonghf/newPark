package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.SubjectRentDao;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class SubjectRentServiceImpl implements SubjectRentService{
	
	private SubjectRentDao subjectRentDao;
	
	public void setSubjectRentDao(SubjectRentDao subjectRentDao) {
		this.subjectRentDao = subjectRentDao;
	}

	@Override
	public Result<SubjectRent> save(SubjectRent t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = subjectRentDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			tr.commit();
			return Result.success(R.SubjectRent.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SubjectRent.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SubjectRent.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<SubjectRent> delete(SubjectRent t) {
		try {
			subjectRentDao.delete(t);
			return Result.success(R.SubjectRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectRent> deleteById(Serializable id) {
		try {
			subjectRentDao.deleteById(id);
			return Result.success(R.SubjectRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectRent> deleteByIds(String ids) {
		try {
			subjectRentDao.deleteByIds(ids);
			return Result.success(R.SubjectRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectRent> update(SubjectRent t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = subjectRentDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			tr.commit();
			return Result.success(R.SubjectRent.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SubjectRent.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SubjectRent.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<SubjectRent> getBeanById(Serializable id) {
		try {
			return Result.value(subjectRentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SubjectRent> getBeanByFilter(Filter filter) {
		try {
			return Result.value(subjectRentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SubjectRent>> getList() {
		try {
			return Result.value(subjectRentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SubjectRent>> getListByFilter(Filter filter) {
		try {
			return Result.value(subjectRentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<List> getListBySql(String sql) {
		try {
			return Result.value(subjectRentDao.getObjectListBySql(sql));
		} catch (Exception e) {
			return Result.failure(R.SubjectRent.LOAD_FAILURE);
		}
	}

}
