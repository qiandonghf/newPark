package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.RewardDao;
import com.wiiy.crm.entity.Reward;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.RewardService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class RewardServiceImpl implements RewardService{
	
	private RewardDao rewardDao;
	
	public void setRewardDao(RewardDao rewardDao) {
		this.rewardDao = rewardDao;
	}

	@Override
	public Result<Reward> save(Reward t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			rewardDao.save(t);
			return Result.success(R.Reward.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Reward.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Reward> delete(Reward t) {
		try {
			rewardDao.delete(t);
			return Result.success(R.Reward.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Reward> deleteById(Serializable id) {
		try {
			rewardDao.deleteById(id);
			return Result.success(R.Reward.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Reward> deleteByIds(String ids) {
		try {
			rewardDao.deleteByIds(ids);
			return Result.success(R.Reward.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Reward> update(Reward t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			rewardDao.update(t);
			return Result.success(R.Reward.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Reward.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Reward> getBeanById(Serializable id) {
		try {
			return Result.value(rewardDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Reward> getBeanByFilter(Filter filter) {
		try {
			return Result.value(rewardDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Reward>> getList() {
		try {
			return Result.value(rewardDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Reward>> getListByFilter(Filter filter) {
		try {
			return Result.value(rewardDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Reward.LOAD_FAILURE);
		}
	}

}
