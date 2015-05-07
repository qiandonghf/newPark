package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.entity.SmsReceiver;
import com.wiiy.oa.dao.SmsReceiverDao;
import com.wiiy.oa.service.SmsReceiverService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class SmsReceiverServiceImpl implements SmsReceiverService{
	
	private SmsReceiverDao smsReceiverDao;
	
	public void setSmsReceiverDao(SmsReceiverDao smsReceiverDao) {
		this.smsReceiverDao = smsReceiverDao;
	}

	@Override
	public Result<SmsReceiver> save(SmsReceiver t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			smsReceiverDao.save(t);
			return Result.success(R.SmsReceiver.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SmsReceiver.class)));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> delete(SmsReceiver t) {
		try {
			smsReceiverDao.delete(t);
			return Result.success(R.SmsReceiver.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> deleteById(Serializable id) {
		try {
			smsReceiverDao.deleteById(id);
			return Result.success(R.SmsReceiver.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> deleteByIds(String ids) {
		try {
			smsReceiverDao.deleteByIds(ids);
			return Result.success(R.SmsReceiver.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> update(SmsReceiver t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			smsReceiverDao.update(t);
			return Result.success(R.SmsReceiver.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SmsReceiver.class)));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> getBeanById(Serializable id) {
		try {
			return Result.value(smsReceiverDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SmsReceiver> getBeanByFilter(Filter filter) {
		try {
			return Result.value(smsReceiverDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SmsReceiver>> getList() {
		try {
			return Result.value(smsReceiverDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SmsReceiver>> getListByFilter(Filter filter) {
		try {
			return Result.value(smsReceiverDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SmsReceiver.LOAD_FAILURE);
		}
	}

}
