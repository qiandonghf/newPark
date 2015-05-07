package com.wiiy.crm.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.BrandDao;
import com.wiiy.crm.entity.Brand;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.BrandService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

public class BrandServiceImpl implements BrandService {
	private BrandDao brandDao;
	public void setBrandDao(BrandDao brandDao) {
		this.brandDao = brandDao;
	}

	@Override
	public Result<Brand> save(Brand t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = brandDao.openSession();
			tr = session.beginTransaction();
			List<Brand> list = brandDao.getListByFilter(new Filter(Brand.class).eq("brandNo", t.getBrandNo()));
			if(list.size()>0 && list!=null){
				return Result.failure("商标编号已存在");
			}
			
			t.setCustomer(new Customer( t.getCustomerId()));
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
			return Result.success(R.Brand.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Brand.class)));
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.Brand.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Brand> update(Brand t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = brandDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			session.save(modifyLog(t, session, "更新"));
			session.save(parkModifyLog(t, session, "更新"));
			tr.commit();
			return Result.success(R.Brand.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Brand.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Brand.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	@Override
	public Result<Brand> delete(Brand t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = brandDao.openSession();
			tr = session.beginTransaction();
			session.save(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			return Result.success(R.Brand.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Brand.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Brand> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = brandDao.openSession();
			tr = session.beginTransaction();
			Brand t = (Brand)session.get(Brand.class, id);
			session.save(modifyLog(t, session, "删除"));
			session.save(parkModifyLog(t, session, "删除"));
			session.delete(t);
			tr.commit();
			return Result.success(R.Brand.DELETE_SUCCESS);
		}  catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Brand.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Brand> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = brandDao.openSession();
			tr = session.beginTransaction();
			List<Brand> list = session.createQuery("from Brand where id in ("+ids+")").list();
			for (Brand t : list) {
				session.save(modifyLog(t, session, "删除"));		
				session.save(parkModifyLog(t, session, "删除"));
				session.delete(t);
			}
			tr.commit();
			return Result.success(R.Brand.DELETE_SUCCESS);
		}  catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Brand.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Brand> getBeanByFilter(Filter filter) {
		try {
			return Result.value(brandDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Brand.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Brand> getBeanById(Serializable id) {
		try {
			return Result.value(brandDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Brand.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Brand>> getList() {
		try {
			return Result.value(brandDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Brand.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Brand>> getListByFilter(Filter filter) {
		try {
			return Result.value(brandDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Brand.LOAD_FAILURE);
		}
	}
	private CustomerModifyLog modifyLog(Brand t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		CustomerModifyLog customerModifyLog = new CustomerModifyLog();
		customerModifyLog.setContent(op+"商标【"+t.getName()+"】    " +customer.getName());
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
	private ParkLog parkModifyLog(Brand t,Session session,String op){
		Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
		ParkLog parkLog = new ParkLog() ;
		parkLog.setContent(op+"商标【"+t.getName()+"】"+"    "+ customer.getName());
		parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
		parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
		parkLog.setCreateTime(new Date());
		return parkLog ;
	}
}
