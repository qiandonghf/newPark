package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.ProjectApplyDao;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.entity.Product;
import com.wiiy.crm.entity.ProjectApply;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.ProjectApplyService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class ProjectApplyServiceImpl implements ProjectApplyService{
	
	private ProjectApplyDao projectApplyDao;
	
	public void setProjectApplyDao(ProjectApplyDao projectApplyDao) {
		this.projectApplyDao = projectApplyDao;
	}

	@Override
	public Result<ProjectApply> save(ProjectApply t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = projectApplyDao.openSession();
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
			return Result.success(R.ProjectApply.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ProjectApply.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ProjectApply.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ProjectApply> delete(ProjectApply t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = projectApplyDao.openSession();
			tr = session.beginTransaction();
			session.delete(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			return Result.success(R.ProjectApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ProjectApply.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ProjectApply> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = projectApplyDao.openSession();
			tr = session.beginTransaction();
			ProjectApply t = (ProjectApply)session.get(ProjectApply.class, id);
			session.delete(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			return Result.success(R.ProjectApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ProjectApply.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ProjectApply> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = projectApplyDao.openSession();
			tr = session.beginTransaction();
			List<ProjectApply> list = session.createQuery("from ProjectApply where id in("+ids+")").list();
			for (ProjectApply t : list) {
				session.delete(modifyLog(t, session, "删除"));
				session.save(parkModifyLog(t, session, "删除"));
				session.delete(t);
			}
			tr.commit();
			return Result.success(R.ProjectApply.DELETE_SUCCESS);
		}catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ProjectApply.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ProjectApply> update(ProjectApply t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = projectApplyDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			session.save(modifyLog(t, session, "更新"));
			session.save(parkModifyLog(t, session, "更新"));
			tr.commit();
			return Result.success(R.ProjectApply.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ProjectApply.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ProjectApply.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ProjectApply> getBeanById(Serializable id) {
		try {
			return Result.value(projectApplyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ProjectApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ProjectApply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(projectApplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ProjectApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ProjectApply>> getList() {
		try {
			return Result.value(projectApplyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ProjectApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ProjectApply>> getListByFilter(Filter filter) {
		try {
			return Result.value(projectApplyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ProjectApply.LOAD_FAILURE);
		}
	}
	private CustomerModifyLog modifyLog(ProjectApply t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		CustomerModifyLog customerModifyLog = new CustomerModifyLog();
		customerModifyLog.setContent("项目申报情况【"+t.getName()+"】");
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
	private ParkLog parkModifyLog(ProjectApply t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		ParkLog parkLog = new ParkLog() ;
		parkLog.setContent(op+"项目申报情况【"+t.getName()+"】" +"    "+customer.getName());
		parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
		parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
		parkLog.setCreateTime(new Date());
		return parkLog ;
	}
}
