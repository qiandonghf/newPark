package com.wiiy.crm.service.impl;


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
import com.wiiy.crm.entity.Copyright;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.dao.CopyrightDao;
import com.wiiy.crm.service.CopyrightService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class CopyrightServiceImpl implements CopyrightService{
	
	private CopyrightDao copyrightDao;
	
	public void setCopyrightDao(CopyrightDao copyrightDao) {
		this.copyrightDao = copyrightDao;
	}

	@Override
	public Result<Copyright> save(Copyright t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = copyrightDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("新建著作权【"+t.getName()+"】");
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
			session.save(customerModifyLog);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("新建著作权【"+t.getName()+"】    " +customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("新建著作权【"+t.getName()+"】");
			return Result.success(R.Copyright.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Copyright.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Copyright.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Copyright> delete(Copyright t) {
		try {
			PbActivator.getOperationLogService().logOP("删除著作权【"+t.getName()+"】");
			copyrightDao.delete(t);
			return Result.success(R.Copyright.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Copyright.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Copyright> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = copyrightDao.openSession();
			tr = session.beginTransaction();
			Copyright t = (Copyright)session.get(Copyright.class, id);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("删除著作权【"+t.getName()+"】");
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
			session.save(customerModifyLog);
			session.delete(t);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("删除著作权【"+t.getName()+"】    " +customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除著作权 【"+t.getName()+"】");
			return Result.success(R.Copyright.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Copyright.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Copyright> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = copyrightDao.openSession();
			tr = session.beginTransaction();
			List<Copyright> list = session.createQuery("from Copyright where id in ("+ids+")").list();
			String str = "" ;
			for (Copyright t : list) {
				Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
				CustomerModifyLog customerModifyLog = new CustomerModifyLog();
				customerModifyLog.setContent("删除著作权【"+t.getName()+"】");
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
				session.save(customerModifyLog);
				session.delete(t);
				str = str +"新建著作权【"+t.getName()+"】    " +customer.getName()+";";
			}
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent(str);
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除著作权:ids为【"+ids+"】");
			return Result.success(R.Copyright.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Copyright.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Copyright> update(Copyright t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = copyrightDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("更新著作权【"+t.getName()+"】");
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
			session.save(customerModifyLog);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("更新著作权【"+t.getName()+"】    " +customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("更新著作权【"+t.getName()+"】");
			return Result.success(R.Copyright.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Copyright.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Copyright.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Copyright> getBeanById(Serializable id) {
		try {
			return Result.value(copyrightDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Copyright.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Copyright> getBeanByFilter(Filter filter) {
		try {
			return Result.value(copyrightDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Copyright.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Copyright>> getList() {
		try {
			return Result.value(copyrightDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Copyright.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Copyright>> getListByFilter(Filter filter) {
		try {
			return Result.value(copyrightDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Copyright.LOAD_FAILURE);
		}
	}

}
