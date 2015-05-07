package com.wiiy.weixin.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.weixin.activator.Activator;
import com.wiiy.weixin.dao.DataDao;
import com.wiiy.weixin.entity.Data;
import com.wiiy.weixin.preferences.R;
import com.wiiy.weixin.service.DataService;

/**
 * @author my
 */
public class DataServiceImpl implements DataService{
	
	private DataDao dataDao;
	
	public void setDataDao(DataDao dataDao) {
		this.dataDao = dataDao;
	}

	@Override
	public Result<Data> save(Data t) {
		try {
			//t.setCreateTime(new Date());
			//t.setCreator(Activator.getSessionUser().getRealName());
			//t.setCreatorId(Activator.getSessionUser().getId());
			//t.setModifyTime(t.getCreateTime());
			///t.setModifier(t.getCreator());
			//t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataDao.save(t);
			return Result.success(R.Data.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Data.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Data> delete(Data t) {
		try {
			dataDao.delete(t);
			return Result.success(R.Data.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Data> deleteById(Serializable id) {
		try {
			dataDao.deleteById(id);
			return Result.success(R.Data.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Data> deleteByIds(String ids) {
		try {
			dataDao.deleteByIds(ids);
			return Result.success(R.Data.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Data> update(Data t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(Activator.getSessionUser().getRealName());
			t.setModifierId(Activator.getSessionUser().getId());
			dataDao.update(t);
			return Result.success(R.Data.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Data.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Data> getBeanById(Serializable id) {
		try {
			return Result.value(dataDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Data> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Data>> getList() {
		try {
			return Result.value(dataDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Data>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Data.LOAD_FAILURE);
		}
	}

}
