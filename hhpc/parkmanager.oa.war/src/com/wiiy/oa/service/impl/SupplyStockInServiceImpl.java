package com.wiiy.oa.service.impl;

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
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SupplyStockInDao;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyStockIn;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SupplyStockInService;

public class SupplyStockInServiceImpl implements SupplyStockInService {
	
	private SupplyStockInDao supplyStockInDao;
	
	public void setSupplyStockInDao(SupplyStockInDao supplyStockInDao) {
		this.supplyStockInDao = supplyStockInDao;
	}

	@Override
	public Result<SupplyStockIn> save(SupplyStockIn t) {
		Session session = null;
		Transaction tr = null;
		try{
			session = supplyStockInDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			if(t.getAmount()==null){
				t.setAmount(0D);
			}
			if(t.getPrice()==null){
				t.setPrice(0D);
			}
			t.setCost(t.getAmount()*t.getPrice());
			OaActivator.getOperationLogService().logOP("添加办公用品入库清单,id为【"+t.getId()+"】");
			session.save(t);
			
			Supply supply = (Supply)session.get(Supply.class, t.getSupplyId());
			supply.setStock(supply.getStock()+t.getAmount());
			session.update(supply);
			
			tr.commit();
			return Result.success(R.SupplyStockIn.SAVE_SUCCESS,t);
		}catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SupplyStockIn.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<SupplyStockIn> delete(SupplyStockIn t) {
		try{
			OaActivator.getOperationLogService().logOP("删除办公用品入库清单,id为【"+t.getId()+"】");
			supplyStockInDao.delete(t);
			return Result.success(R.SupplyStockIn.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyStockIn> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除办公用品入库清单,id为【"+id+"】");
			supplyStockInDao.deleteById(id);
			return Result.success(R.SupplyStockIn.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyStockIn.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyStockIn> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除办公用品入库清单,id为【"+id+"】");
			}
			supplyStockInDao.deleteByIds(ids);
			return Result.success(R.SupplyStockIn.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyStockIn.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyStockIn> update(SupplyStockIn t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			if(t.getAmount()==null){
				t.setAmount(0D);
			}
			if(t.getPrice()==null){
				t.setPrice(0D);
			}
			t.setCost(t.getAmount()*t.getPrice());
			supplyStockInDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的办公用品入库清单");
			return Result.success(R.SupplyStockIn.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyStockIn.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyStockIn.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SupplyStockIn> getBeanById(Serializable id) {
		try {
			return Result.value(supplyStockInDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SupplyStockIn> getBeanByFilter(Filter filter) {
		try {
			return Result.value(supplyStockInDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyStockIn>> getList() {
		try {
			return Result.value(supplyStockInDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DocFolder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyStockIn>> getListByFilter(Filter filter) { 
		try {
			return Result.value(supplyStockInDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.LOAD_FAILURE);
		}
	}

	@Override
	public Result updateSupply(SupplyStockIn t, Double count) {
		Session session = null;
		Transaction tr = null;
		try {
			session = supplyStockInDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			session.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的办公用品入库清单");
			
			Supply supply = (Supply)session.get(Supply.class, t.getSupplyId());
			supply.setStock(supply.getStock()+t.getAmount()-count);
			session.update(supply);
			
			tr.commit();
			return Result.success(R.SupplyStockIn.UPDATE_SUCCESS,t);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SupplyStockIn.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}
}
