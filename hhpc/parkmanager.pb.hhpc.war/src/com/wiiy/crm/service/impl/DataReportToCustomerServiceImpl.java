package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.dao.DataReportToCustomerDao;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.crm.service.DataReportToCustomerService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataReportToCustomerServiceImpl implements DataReportToCustomerService{
	
	private DataReportToCustomerDao dataReportToCustomerDao;
	
	public void setDataReportToCustomerDao(DataReportToCustomerDao dataReportToCustomerDao) {
		this.dataReportToCustomerDao = dataReportToCustomerDao;
	}

	@Override
	public Result<DataReportToCustomer> save(DataReportToCustomer t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataReportToCustomerDao.save(t);
			return Result.success(R.DataReportToCustomer.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportToCustomer.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataReportToCustomer> delete(DataReportToCustomer t) {
		try {
			dataReportToCustomerDao.delete(t);
			return Result.success(R.DataReportToCustomer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportToCustomer> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportToCustomerDao.openSession();
			tr = session.beginTransaction();
			session.createQuery("delete from DataReportValue where reportCustomerId = "+id).executeUpdate();
			session.createQuery("delete from DataReportToCustomer where id = "+id).executeUpdate();
			tr.commit();
			return Result.success(R.DataReportToCustomer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (ConstraintViolationException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(new FKConstraintException(e).getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<DataReportToCustomer> deleteByIds(String ids) {
		try {
			dataReportToCustomerDao.deleteByIds(ids);
			return Result.success(R.DataReportToCustomer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportToCustomer> update(DataReportToCustomer t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			dataReportToCustomerDao.update(t);
			return Result.success(R.DataReportToCustomer.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportToCustomer.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataReportToCustomer> getBeanById(Serializable id) {
		try {
			return Result.value(dataReportToCustomerDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataReportToCustomer> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataReportToCustomerDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportToCustomer>> getList() {
		try {
			return Result.value(dataReportToCustomerDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportToCustomer>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataReportToCustomerDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportToCustomer.LOAD_FAILURE);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Result<List<Customer>> getCustomerListByReportId(Long reportId) {
		List<Customer> list = dataReportToCustomerDao.getObjectListByHql("select rc.customer from DataReportToCustomer rc where rc.reportId = "+reportId);
		return Result.value(list);
	}

	@Override
	public Result report(Long id, String propertyIds, String propertyValues) {
		return report(id,CustomerReportStatusEnum.PUB,propertyIds,propertyValues);
	}		


	@Override
	public Result<Integer> countByFilter(Filter filter) {
		return Result.value(dataReportToCustomerDao.getRowCount(filter));
	}

	@SuppressWarnings("unchecked")
	@Override
	public Result report(Long id, CustomerReportStatusEnum status,
			String propertyIds, String propertyValues) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportToCustomerDao.openSession();
			tr = session.beginTransaction();
			DataReportToCustomer t = (DataReportToCustomer) session.get(DataReportToCustomer.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setFinished(BooleanEnum.YES);
			t.setStatus(status);
			if(status.equals(CustomerReportStatusEnum.PUB)){
				t.setFillTime(new Date());
			}
			session.update(t);
			List<DataReportProperty> dataReportPropertyList = session.createQuery("from DataReportProperty where id in ("+propertyIds+")").list();
			Map<Long,DataReportProperty> pMap = new HashMap<Long,DataReportProperty>();
			for (DataReportProperty dataReportProperty : dataReportPropertyList) {
				pMap.put(dataReportProperty.getId(), dataReportProperty);
			}
			String[] ids= propertyIds.split(",");
			String[] values = propertyValues.split(",");
			for (int i = 0; i < ids.length; i++) {
				Long pId = Long.parseLong(ids[i].trim());
				DataReportProperty p = pMap.get(pId);
				String v = values[i].trim();
				if(v!=null && v.length()>0){
					DataReportValue value = new DataReportValue();
					switch (p.getDataType()) {
						case DATETIME:
							value.setDateVal(DateUtil.parse(v));
							break;
						case DOUBLE:
							value.setDoubleVal(Double.parseDouble(v));
							break;
						case INT:
							value.setIntVal(Integer.parseInt(v));
							break;
						case SELECT:
							value.setSelVal(v);
							break;
						case STRING:
							value.setStrVal(v);
							break;
					}
					value.setPropertyId(pId);
					value.setReportCustomerId(id);
					value.setCreateTime(new Date());
					value.setCreator(PbActivator.getSessionUser().getRealName());
					value.setCreatorId(PbActivator.getSessionUser().getId());
					value.setModifyTime(value.getCreateTime());
					value.setModifier(value.getCreator());
					value.setModifierId(value.getCreatorId());
					value.setEntityStatus(EntityStatus.NORMAL);
					session.save(value);
				}
			}
			tr.commit();
			if(status.equals(CustomerReportStatusEnum.SAVED)) return Result.success("保存成功");
			else if(status.equals(CustomerReportStatusEnum.PUB)) return Result.success(R.DataReportToCustomer.REPORT_SUCCESS);
			return null;
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DataReportToCustomer.REPORT_FAILURE);
		} finally {
			session.close();
		}
	}

	/**
	 * 小企业利润表/负债表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Result reportProfit(Long id, CustomerReportStatusEnum status,
			String propertyIds, String propertyValues) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportToCustomerDao.openSession();
			tr = session.beginTransaction();
			DataReportToCustomer t = (DataReportToCustomer) session.get(DataReportToCustomer.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setFinished(BooleanEnum.YES);
			t.setStatus(status);
			if(status.equals(CustomerReportStatusEnum.PUB)){
				t.setFillTime(new Date());
			}
			session.update(t);
			List<DataReportProperty> dataReportPropertyList = session.createQuery("from DataReportProperty where reportId = "+t.getReportId()+" and propertyId in ("+propertyIds+")").list();
			Map<Long,DataReportProperty> pMap = new HashMap<Long,DataReportProperty>();
			for (DataReportProperty dataReportProperty : dataReportPropertyList) {
				pMap.put(dataReportProperty.getPropertyId(), dataReportProperty);
			}
			String[] ids= propertyIds.split(",");
			String[] values = propertyValues.split(",");
			for (int i = 0; i < ids.length; i++) {
				Long pId = Long.parseLong(ids[i].trim());
				DataReportProperty p = pMap.get(pId);
				String v = values[i].trim();
				if(v!=null && v.length()>0){
					DataReportValue value = new DataReportValue();
					value.setDoubleVal(Double.parseDouble(v));
					value.setPropertyId(p.getId());
					value.setReportCustomerId(id);
					value.setCreateTime(new Date());
					value.setCreator(PbActivator.getSessionUser().getRealName());
					value.setCreatorId(PbActivator.getSessionUser().getId());
					value.setModifyTime(value.getCreateTime());
					value.setModifier(value.getCreator());
					value.setModifierId(value.getCreatorId());
					value.setEntityStatus(EntityStatus.NORMAL);
					session.save(value);
				}
			}
			tr.commit();
			if(status.equals(CustomerReportStatusEnum.SAVED)) return Result.success("保存成功");
			else if(status.equals(CustomerReportStatusEnum.PUB)) return Result.success(R.DataReportToCustomer.REPORT_SUCCESS);
			return null;
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DataReportToCustomer.REPORT_FAILURE);
		} finally {
			session.close();
		}
	}
/*	*//**
	 * 
	 *//*
	@SuppressWarnings("unchecked")
	@Override
	public Result reportDebt(Long id, CustomerReportStatusEnum status,
			String propertyIds, String propertyValues) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportToCustomerDao.openSession();
			tr = session.beginTransaction();
			DataReportToCustomer t = (DataReportToCustomer) session.get(DataReportToCustomer.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setFinished(BooleanEnum.YES);
			t.setStatus(status);
			if(status.equals(CustomerReportStatusEnum.PUB)){
				t.setFillTime(new Date());
			}
			session.update(t);
			List<DataReportProperty> dataReportPropertyList = session.createQuery("from DataReportProperty where reportId = "+t.getReportId()+" and propertyId in ("+propertyIds+")").list();
			Map<Long,Long> pMap = new HashMap<Long,Long>();
			for (DataReportProperty dataReportProperty : dataReportPropertyList) {
				pMap.put(dataReportProperty.getPropertyId(), dataReportProperty.getId());
			}
			String[] ids= propertyIds.split(",");
			String[] values = propertyValues.split(",");
			int j = 0;
			for (int i = 0; i < ids.length; i++) {
				Long pId = pMap.get(Long.parseLong(ids[i].trim()));
				String v = values[j++].trim();//期末余额
				String v2 = values[j++].trim();//年初余额
				DataReportValue value = new DataReportValue();
				if(v!=null && v.length()>0){
					value.setFinalBalance(Double.parseDouble(v));
				}
				if(v2!=null && v2.length()>0){
					value.setBeginBalance(Double.parseDouble(v2));
				}
				value.setPropertyId(pId);
				value.setReportCustomerId(id);
				value.setCreateTime(new Date());
				value.setCreator(PbActivator.getSessionUser().getRealName());
				value.setCreatorId(PbActivator.getSessionUser().getId());
				value.setModifyTime(value.getCreateTime());
				value.setModifier(value.getCreator());
				value.setModifierId(value.getCreatorId());
				value.setEntityStatus(EntityStatus.NORMAL);
				session.save(value);
			}
			tr.commit();
			if(status.equals(CustomerReportStatusEnum.SAVED)) return Result.success("保存成功");
			else if(status.equals(CustomerReportStatusEnum.PUB)) return Result.success(R.DataReportToCustomer.REPORT_SUCCESS);
			return null;
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DataReportToCustomer.REPORT_FAILURE);
		} finally {
			session.close();
		}
	}*/

	@Override
	public Result reportPub(Long id) {
		DataReportToCustomer dataReportToCustomer = dataReportToCustomerDao.getBeanById(id);
		dataReportToCustomer.setStatus(CustomerReportStatusEnum.PUB);
		dataReportToCustomer.setFillTime(new Date());
		dataReportToCustomerDao.update(dataReportToCustomer);
		return Result.success("上报成功");
	}

	@Override
	public Result back(Long id, String suggestion) {
		DataReportToCustomer dbBean = dataReportToCustomerDao.getBeanById(id);
		dbBean.setStatus(CustomerReportStatusEnum.BACK);
		dataReportToCustomerDao.update(dbBean);
		sendMail(dbBean.getCustomerId(),suggestion);
		return Result.success("退回成功");
	}
	
	public void sendMail(Long customerId,String suggestion){
		Session session = dataReportToCustomerDao.openSession();
		Customer customer = (Customer) session.get(Customer.class, customerId);
		Contect contect = (Contect) session.createQuery("from Contect where customerId = "+customerId+" and main = '"+BooleanEnum.YES+"'").uniqueResult();
		if(contect!=null) {
			SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
			if(sysEmailSenderPubService!=null) {
				sysEmailSenderPubService.send(contect.getEmail(),"您好 "+customer.getName()+" 您的数据报送被退回 原因如下："+suggestion,"数据报送退回通知");
			}
		}
	}
}
