package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.BillTypeDao;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.BillTypeService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class BillTypeServiceImpl implements BillTypeService{
	
	private BillTypeDao billTypeDao;
	
	public void setBillTypeDao(BillTypeDao billTypeDao) {
		this.billTypeDao = billTypeDao;
	}

	@Override
	public Result<BillType> save(BillType t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			billTypeDao.save(t);
			return Result.success(R.BillType.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillType.class)));
		} catch (Exception e) {
			return Result.failure(R.BillType.SAVE_FAILURE);
		}
	}

	@Override
	public Result<BillType> delete(BillType t) {
		try {
			billTypeDao.delete(t);
			return Result.success(R.BillType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillType> deleteById(Serializable id) {
		try {
			billTypeDao.deleteById(id);
			return Result.success(R.BillType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillType> deleteByIds(String ids) {
		try {
			billTypeDao.deleteByIds(ids);
			return Result.success(R.BillType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillType> update(BillType t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			billTypeDao.update(t);
			return Result.success(R.BillType.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillType.class)));
		} catch (Exception e) {
			return Result.failure(R.BillType.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<BillType> getBeanById(Serializable id) {
		try {
			return Result.value(billTypeDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.BillType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BillType> getBeanByFilter(Filter filter) {
		try {
			return Result.value(billTypeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillType>> getList() {
		try {
			return Result.value(billTypeDao.getList());
		} catch (Exception e) {
			return Result.failure(R.BillType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillType>> getListByFilter(Filter filter) {
		try {
			return Result.value(billTypeDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BillType> getBillType(String typeName) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billTypeDao.openSession();
			tr = session.beginTransaction();
			BillType billType = (BillType) session.createQuery("from BillType where typeName = '"+typeName+"'").uniqueResult();
			if(billType==null){
				billType = new BillType();
				billType.setTypeName(typeName);
				billType.setCreateTime(new Date());
				billType.setCreator(PbActivator.getSessionUser().getRealName());
				billType.setCreatorId(PbActivator.getSessionUser().getId());
				billType.setModifyTime(billType.getCreateTime());
				billType.setModifier(billType.getCreator());
				billType.setModifierId(billType.getCreatorId());
				billType.setEntityStatus(EntityStatus.NORMAL);
				session.save(billType);
			}
			tr.commit();
			return Result.value(billType);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.BillPlanRent.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<BillType> checkBillType(BillType billType) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billTypeDao.openSession();
			tr = session.beginTransaction();
			BillType dbType = (BillType) session.createQuery("from BillType where typeName = '"+billType.getTypeName()+"'").uniqueResult();
			if(dbType==null){
				billType.setCreateTime(new Date());
				billType.setCreator(PbActivator.getSessionUser().getRealName());
				billType.setCreatorId(PbActivator.getSessionUser().getId());
				billType.setModifyTime(billType.getCreateTime());
				billType.setModifier(billType.getCreator());
				billType.setModifierId(billType.getCreatorId());
				billType.setEntityStatus(EntityStatus.NORMAL);
				session.save(billType);
			} else {
				BeanUtil.copyProperties(dbType, billType);
			}
			tr.commit();
			return Result.value(billType);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.BillPlanRent.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	@Override
	public Result<List<BillType>> getListByHql(String hql) {
		try {
			return Result.value(billTypeDao.getListByHql(hql));
		} catch (Exception e) {
			return Result.failure(R.BillType.LOAD_FAILURE);
		}
	}
}
