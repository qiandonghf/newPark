package com.wiiy.pb.service.impl;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.PropertyFixDao;
import com.wiiy.pb.entity.PropertyFix;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.PropertyFixService;

public class PropertyFixServiceImpl implements PropertyFixService{
	private PropertyFixDao propertyFixDao;
	public void setPropertyFixDao(PropertyFixDao propertyFixDao) {
		this.propertyFixDao = propertyFixDao;
	}

	@Override
	public Result<PropertyFix> save(PropertyFix t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			propertyFixDao.save(t);
			PbActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的物业报修单");
			return Result.success(R.PropertyFix.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),PropertyFix.class)));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.SAVE_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> delete(PropertyFix t) {
		try {
			propertyFixDao.delete(t);
			PbActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的物业报修单");
			return Result.success(R.PropertyFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> deleteById(Serializable id) {
		try {
			PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的物业报修单");
			propertyFixDao.deleteById(id);
			return Result.success(R.PropertyFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的物业报修单");
			}
			propertyFixDao.deleteByIds(ids);
			return Result.success(R.PropertyFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> update(PropertyFix t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			propertyFixDao.update(t);
			PbActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的物业报修单");
			return Result.success(R.PropertyFix.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),PropertyFix.class)));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> getBeanById(Serializable id) {
		try {
			return Result.value(propertyFixDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<PropertyFix> getBeanByFilter(Filter filter) {
		try {
			return Result.value(propertyFixDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<PropertyFix>> getList() {
		try {
			return Result.value(propertyFixDao.getList());
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<PropertyFix>> getListByFilter(Filter filter) {
		try {
			return Result.value(propertyFixDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.PropertyFix.LOAD_FAILURE);
		}
	}
	//订单号
	@Override
	public String getOrderNum() {
		String orderNum = "";
		int num = 1;
		String timeNum = DateUtil.format(new Date(),"yyyy")+DateUtil.format(new Date(),"MM")+DateUtil.format(new Date(),"dd")+"0";
		orderNum = timeNum+num;
		List<PropertyFix> list = getList().getValue();
		for(PropertyFix pf : list){
			if(pf.getOddNo()!=null && pf.getOddNo().equals(orderNum)){
				num++;
				orderNum = timeNum+num;
			}
		}
		return orderNum;
	}
}
