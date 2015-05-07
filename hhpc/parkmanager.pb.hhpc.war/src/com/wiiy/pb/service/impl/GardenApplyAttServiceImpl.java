package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.GardenApplyAtt;
import com.wiiy.pb.dao.GardenApplyAttDao;
import com.wiiy.pb.service.GardenApplyAttService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class GardenApplyAttServiceImpl implements GardenApplyAttService{
	
	private GardenApplyAttDao gardenApplyAttDao;
	
	public void setGardenApplyAttDao(GardenApplyAttDao gardenApplyAttDao) {
		this.gardenApplyAttDao = gardenApplyAttDao;
	}

	@Override
	public Result<GardenApplyAtt> save(GardenApplyAtt t) {
		try {
			t.setCreateTime(new Date());
			User user = PbActivator.getSessionUser();
			if (user != null) {
				
				t.setCreator(user.getRealName());
				t.setCreatorId(user.getId());
				t.setModifier(t.getCreator());
				t.setModifierId(t.getCreatorId());
			}
			t.setModifyTime(t.getCreateTime());
			t.setEntityStatus(EntityStatus.NORMAL);
			gardenApplyAttDao.save(t);
			return Result.success(R.GardenApplyAtt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyAtt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> delete(GardenApplyAtt t) {
		try {
			gardenApplyAttDao.delete(t);
			return Result.success(R.GardenApplyAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> deleteById(Serializable id) {
		try {
			gardenApplyAttDao.deleteById(id);
			return Result.success(R.GardenApplyAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> deleteByIds(String ids) {
		try {
			gardenApplyAttDao.deleteByIds(ids);
			return Result.success(R.GardenApplyAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> update(GardenApplyAtt t) {
		try {
			t.setModifyTime(new Date());
			User user = PbActivator.getSessionUser();
			if (user != null) {
				t.setModifier(user.getRealName());
				t.setModifierId(user.getId());
			}
			gardenApplyAttDao.update(t);
			return Result.success(R.GardenApplyAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyAtt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> getBeanById(Serializable id) {
		try {
			return Result.value(gardenApplyAttDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyAtt>> getList() {
		try {
			return Result.value(gardenApplyAttDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyAttDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyAtt.LOAD_FAILURE);
		}
	}

}
