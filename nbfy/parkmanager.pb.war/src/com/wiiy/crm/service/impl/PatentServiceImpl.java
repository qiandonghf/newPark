package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.PatentDao;
import com.wiiy.crm.entity.Brand;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.entity.Patent;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.PatentService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class PatentServiceImpl implements PatentService{
	
	private PatentDao patentDao;
	
	public void setPatentDao(PatentDao patentDao) {
		this.patentDao = patentDao;
	}

	@Override
	public Result<Patent> save(Patent t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = patentDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			session.save(modifyLog(t, session, "新建"));
			session.save(parkModifyLog(t, session, "新建"));
			tr.commit();
			PbActivator.getOperationLogService().logOP("新建专利【"+t.getName()+"】");
			return Result.success(R.Patent.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Patent.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Patent.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Patent> delete(Patent t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = patentDao.openSession();
			tr = session.beginTransaction();
			session.delete(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除专利【"+t.getName()+"】");
			return Result.success(R.Patent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Patent.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Patent> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = patentDao.openSession();
			tr = session.beginTransaction();
			Patent t = (Patent)session.get(Patent.class, id);
			session.save(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除专利:id为【"+id+"】");
			return Result.success(R.Patent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Patent.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Patent> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = patentDao.openSession();
			tr = session.beginTransaction();
			List<Patent> list = session.createQuery("from Patent where id in ("+ids+")").list();
			for (Patent t : list) {
				session.save(modifyLog(t, session, "删除"));
				session.save(parkModifyLog(t, session, "删除"));
				session.delete(t);
			}
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除专利:ids为【"+ids+"】");
			return Result.success(R.Patent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Patent.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Patent> update(Patent t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = patentDao.openSession();
			tr = session.beginTransaction();
			
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			session.save(modifyLog(t, session, "更新"));
			session.save(parkModifyLog(t, session, "更新"));
			tr.commit();
			PbActivator.getOperationLogService().logOP("更新专利【"+t.getName()+"】");
			return Result.success(R.Patent.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Patent.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Patent.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Patent> getBeanById(Serializable id) {
		try {
			return Result.value(patentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Patent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Patent> getBeanByFilter(Filter filter) {
		try {
			return Result.value(patentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Patent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Patent>> getList() {
		try {
			return Result.value(patentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Patent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Patent>> getListByFilter(Filter filter) {
		try {
			return Result.value(patentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Patent.LOAD_FAILURE);
		}
	}
	
	private CustomerModifyLog modifyLog(Patent t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		CustomerModifyLog customerModifyLog = new CustomerModifyLog();
		customerModifyLog.setContent(op+"专利【"+t.getName()+"】");
		customerModifyLog.setCustomer(customer);
		customerModifyLog.setCustomerId(t.getCustomerId());
		customerModifyLog.setCreateTime(new Date());
		customerModifyLog.setCreator(PbActivator.getSessionUser().getRealName());
		customerModifyLog.setCreatorId(PbActivator.getSessionUser().getId());
		customerModifyLog.setModifyTime(new Date());
		customerModifyLog.setModifier(t.getCreator());
		customerModifyLog.setModifierId(t.getCreatorId());
		customerModifyLog.setModifyLogTime(t.getCreateTime());
		customerModifyLog.setEntityStatus(EntityStatus.NORMAL);
		return customerModifyLog;
	}
	private ParkLog parkModifyLog(Patent t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		ParkLog parkLog = new ParkLog() ;
		parkLog.setContent(op+"专利【"+t.getName()+"】" +"    "+customer.getName());
		parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
		parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
		parkLog.setCreateTime(new Date());
		return parkLog ;
	}
}
