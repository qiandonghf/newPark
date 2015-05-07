package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.MeetingDao;
import com.wiiy.oa.entity.Meeting;
import com.wiiy.oa.entity.MeetingAtt;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.MeetingService;

/**
 * @author my
 */
public class MeetingServiceImpl implements MeetingService{
	
	private MeetingDao meetingDao;
	
	public void setMeetingDao(MeetingDao meetingDao) {
		this.meetingDao = meetingDao;
	}

	@Override
	public Result<Meeting> save(Meeting t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			meetingDao.save(t);
			return Result.success(R.Meeting.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meeting.class)));
		} catch (Exception e) {
			return Result.failure(R.Meeting.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Meeting> delete(Meeting t) {
		try {
			meetingDao.delete(t);
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meeting.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Meeting> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meetingDao.openSession();
			tr = session.beginTransaction();
			Meeting meeting = getBeanById(id).getValue();
			List<MeetingAtt> list = session.createQuery(
					"from MeetingAtt where meetingId = " + id).list();
			for (MeetingAtt meetingAtt : list) {
				String path = meetingAtt.getNewName();
				OaActivator.getResourcesService().delete(path);
				session.delete(meetingAtt);
			}
			session.delete(meeting);
			tr.commit();
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meeting.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Meeting> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meetingDao.openSession();
			tr = session.beginTransaction();
			List<Meeting> list = session.createQuery(
					"from Meeting where id in (" + ids+")").list();
			List<MeetingAtt> list2 = session.createQuery("from MeetingAtt").list();
			Map<Long,Meeting> map = new HashMap<Long, Meeting>();
			for (Meeting meeting : list) {
				map.put(meeting.getId(), meeting);
			}
			
			for (MeetingAtt meetingAtt : list2) {
				if(map.get(meetingAtt.getMeetingId())!=null){
					String path = meetingAtt.getNewName();
					OaActivator.getResourcesService().delete(path);
					session.delete(meetingAtt);
				}
			}
			for (Meeting meeting : list) {
				session.delete(meeting);
			}
			tr.commit();
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meeting.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	@Override
	public Result<Meeting> update(Meeting t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			meetingDao.update(t);
			return Result.success(R.Meeting.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meeting.class)));
		} catch (Exception e) {
			return Result.failure(R.Meeting.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Meeting> getBeanById(Serializable id) {
		try {
			return Result.value(meetingDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Meeting> getBeanByFilter(Filter filter) {
		try {
			return Result.value(meetingDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Meeting>> getList() {
		try {
			return Result.value(meetingDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Meeting>> getListByFilter(Filter filter) {
		try {
			return Result.value(meetingDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Meeting> update(Meeting t, String attAddress) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meetingDao.openSession();
			tr = session.beginTransaction();
			
			List<MeetingAtt> list = session.createQuery("from MeetingAtt where meetingId = "+t.getId()).list();
			for (MeetingAtt meetingAtt : list) {
				session.delete(meetingAtt);
			}
			if(attAddress!=null && !attAddress.equals("")){
				String[] files = attAddress.split(";");
				for (String string : files) {
					MeetingAtt meetingAtt = new MeetingAtt();
					meetingAtt.setName(string.split(",")[2]);
					meetingAtt.setSize(Long.parseLong(string.split(",")[1]));
					meetingAtt.setNewName(string.split(",")[0]);
					meetingAtt.setMeetingId(t.getId());
					setcreatemodify(meetingAtt);
					session.save(meetingAtt);
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			session.update(t);
			tr.commit();
			return Result.success(R.Meeting.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meeting.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meeting.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	public void setcreatemodify(BaseEntity t){
		t.setCreateTime(new Date());
		t.setCreator(OaActivator.getSessionUser().getRealName());
		t.setCreatorId(OaActivator.getSessionUser().getId());
		t.setModifyTime(t.getCreateTime());
		t.setModifier(t.getCreator());
		t.setModifierId(t.getCreatorId());
		t.setEntityStatus(EntityStatus.NORMAL);
	}

}
