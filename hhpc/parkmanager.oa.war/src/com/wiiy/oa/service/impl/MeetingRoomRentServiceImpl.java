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
import com.wiiy.oa.entity.MeetingRoomRent;
import com.wiiy.oa.dao.MeetingRoomRentDao;
import com.wiiy.oa.service.MeetingRoomRentService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class MeetingRoomRentServiceImpl implements MeetingRoomRentService{
	
	private MeetingRoomRentDao meetingRoomRentDao;
	
	public void setMeetingRoomRentDao(MeetingRoomRentDao meetingRoomRentDao) {
		this.meetingRoomRentDao = meetingRoomRentDao;
	}

	@Override
	public Result<MeetingRoomRent> save(MeetingRoomRent t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			meetingRoomRentDao.save(t);
			return Result.success(R.MeetingRoomRent.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeetingRoomRent.class)));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.SAVE_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> delete(MeetingRoomRent t) {
		try {
			meetingRoomRentDao.delete(t);
			return Result.success(R.MeetingRoomRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> deleteById(Serializable id) {
		try {
			meetingRoomRentDao.deleteById(id);
			return Result.success(R.MeetingRoomRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> deleteByIds(String ids) {
		try {
			meetingRoomRentDao.deleteByIds(ids);
			return Result.success(R.MeetingRoomRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> update(MeetingRoomRent t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			meetingRoomRentDao.update(t);
			return Result.success(R.MeetingRoomRent.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeetingRoomRent.class)));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> getBeanById(Serializable id) {
		try {
			return Result.value(meetingRoomRentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<MeetingRoomRent> getBeanByFilter(Filter filter) {
		try {
			return Result.value(meetingRoomRentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeetingRoomRent>> getList() {
		try {
			return Result.value(meetingRoomRentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeetingRoomRent>> getListByFilter(Filter filter) {
		try {
			return Result.value(meetingRoomRentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.MeetingRoomRent.LOAD_FAILURE);
		}
	}

}
