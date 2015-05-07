package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

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
import com.wiiy.oa.dao.MeetingAttDao;
import com.wiiy.oa.entity.Meeting;
import com.wiiy.oa.entity.MeetingAtt;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.MeetingAttService;
import com.wiiy.oa.service.MeetingService;

/**
 * @author my
 */
public class MeetingAttServiceImpl implements MeetingAttService{
	
	private MeetingAttDao meetingAttDao;
	
	private MeetingService meetingService;
	
	public void setMeetingService(MeetingService meetingService) {
		this.meetingService = meetingService;
	}
	
	public void setMeetingAttDao(MeetingAttDao meetingAttDao) {
		this.meetingAttDao = meetingAttDao;
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

	@Override
	public Result<MeetingAtt> save(MeetingAtt t, String attAddress) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meetingAttDao.openSession();
			tr = session.beginTransaction();
			setcreatemodify(t);
			
			Meeting meeting = new Meeting();
			meeting.setTitle(t.getMeeting().getTitle());
			if(t.getMeeting().getContent()!=null){
				meeting.setContent(t.getMeeting().getContent());
			}
			meeting.setMeetingTime(t.getMeeting().getMeetingTime());
			meeting.setMeetingTypeId(t.getMeeting().getMeetingTypeId());
			
			setcreatemodify(meeting);
			
			session.save(meeting);

			t.setMeetingId(meeting.getId());
			if(attAddress!=null && !attAddress.equals("")){
				String[] files = attAddress.split(";");
				for (String string : files) {
					MeetingAtt meetingAtt = new MeetingAtt();
					t.setName(string.split(",")[2]);
					t.setSize(Long.parseLong(string.split(",")[1]));
					t.setNewName(string.split(",")[0]);
					BeanUtil.copyProperties(t, meetingAtt);
					session.save(meetingAtt);
				}
			}
			tr.commit();
			return Result.success(R.Meeting.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeetingAtt.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meeting.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}


	@Override
	public Result<MeetingAtt> save(MeetingAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			Meeting meeting = new Meeting();
			meeting.setTitle(t.getMeeting().getTitle());
			if(t.getMeeting().getContent()!=null){
				meeting.setContent(t.getMeeting().getContent());
			}
			meeting.setMeetingTime(t.getMeeting().getMeetingTime());
			meetingService.save(meeting);
			t.setMeetingId(meeting.getId());
			meetingAttDao.save(t);
			return Result.success(R.Meeting.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeetingAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.Meeting.SAVE_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> delete(MeetingAtt t) {
		try {
			meetingAttDao.delete(t);
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meeting.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> deleteById(Serializable id) {
		try {
			/*MeetingAtt t = getBeanById(id).getValue();
			Meeting meeting = meetingService.getBeanById(t.getMeetingId()).getValue();
			meetingService.delete(meeting);*/
			meetingAttDao.deleteById(id);
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meeting.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> deleteByIds(String ids) {
		try {
			/*List<Long> list = meetingAttDao
					.getObjectListByHql("select m.meeting_id from MeetingAtt m where m.id in ("
							+ ids + ")");
			for (Long id : list) {
				meetingService.deleteById(id);
			}*/
			meetingAttDao.deleteByIds(ids);
			return Result.success(R.Meeting.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meeting.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> update(MeetingAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			Meeting meeting = meetingService.getBeanById(t.getMeetingId()).getValue();
			meeting.setTitle(t.getMeeting().getTitle());
			if(t.getMeeting().getContent()!=null){
				meeting.setContent(t.getMeeting().getContent());
			}
			meeting.setMeetingTime(t.getMeeting().getMeetingTime());
			meetingService.update(meeting);
			meetingAttDao.update(t);
			return Result.success(R.Meeting.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeetingAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.Meeting.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> getBeanById(Serializable id) {
		try {
			return Result.value(meetingAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<MeetingAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(meetingAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeetingAtt>> getList() {
		try {
			return Result.value(meetingAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeetingAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(meetingAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meeting.LOAD_FAILURE);
		}
	}

}
