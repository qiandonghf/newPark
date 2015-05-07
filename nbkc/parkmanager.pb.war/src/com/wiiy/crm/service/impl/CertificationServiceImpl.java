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
import com.wiiy.crm.entity.Certification;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.dao.CertificationDao;
import com.wiiy.crm.service.CertificationService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class CertificationServiceImpl implements CertificationService{
	
	private CertificationDao certificationDao;
	
	public void setCertificationDao(CertificationDao certificationDao) {
		this.certificationDao = certificationDao;
	}

	@Override
	public Result<Certification> save(Certification t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = certificationDao.openSession();
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
			customerModifyLog.setContent("新建认证【"+t.getName()+"】");
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
			parkLog.setContent("新建认证【"+t.getName()+"】    "+customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("新建认证【"+t.getName()+"】");
			return Result.success(R.Certification.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Certification.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Certification.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Certification> delete(Certification t) {
		try {
			PbActivator.getOperationLogService().logOP("删除认证【"+t.getName()+"】");
			certificationDao.delete(t);
			return Result.success(R.Certification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Certification.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Certification> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = certificationDao.openSession();
			tr = session.beginTransaction();
			Certification t = (Certification)session.get(Certification.class, id);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("删除认证【"+t.getName()+"】");
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
			parkLog.setContent("删除认证【"+t.getName()+"】    "+customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			session.delete(t);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除认证:id为【"+id+"】");
			return Result.success(R.Certification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Certification.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}
	

	@Override
	public Result<Certification> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = certificationDao.openSession();
			tr = session.beginTransaction();
			List<Certification> list = session.createQuery("from Certification where id in ("+ids+")").list();
			String  str = "" ;
			for (Certification t : list) {
				Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
				CustomerModifyLog customerModifyLog = new CustomerModifyLog();
				customerModifyLog.setContent("删除认证【"+t.getName()+"】");
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
				str = str +"删除认证【"+t.getName()+"】       "+customer.getName()+";";
			}
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent(str);
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除认证:ids为【"+ids+"】");
			return Result.success(R.Certification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Certification.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Certification> update(Certification t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = certificationDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("更新认证【"+t.getName()+"】");
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
			parkLog.setContent("更新认证【"+t.getName()+"】    " +customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
			session.save(parkLog);
			tr.commit();
			PbActivator.getOperationLogService().logOP("更新认证【"+t.getName()+"】");
			return Result.success(R.Certification.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Certification.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Certification.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Certification> getBeanById(Serializable id) {
		try {
			return Result.value(certificationDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Certification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Certification> getBeanByFilter(Filter filter) {
		try {
			return Result.value(certificationDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Certification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Certification>> getList() {
		try {
			return Result.value(certificationDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Certification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Certification>> getListByFilter(Filter filter) {
		try {
			return Result.value(certificationDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Certification.LOAD_FAILURE);
		}
	}

}
