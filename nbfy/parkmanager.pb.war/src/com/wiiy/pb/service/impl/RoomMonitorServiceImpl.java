package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.SendTimeTypeEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.external.service.dto.EmailDto;
import com.wiiy.external.service.dto.EmailReceiverDto;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.RoomMonitorDao;
import com.wiiy.pb.entity.RoomMonitor;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.RoomMonitorService;

/**
 * @author my
 */
public class RoomMonitorServiceImpl implements RoomMonitorService{
	
	private RoomMonitorDao roomMonitorDao;
	
	public void setRoomMonitorDao(RoomMonitorDao roomMonitorDao) {
		this.roomMonitorDao = roomMonitorDao;
	}

	@Override
	public Result<RoomMonitor> save(RoomMonitor t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roomMonitorDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			if(t.getDefaultEmail()==null){
				t.setDefaultEmail(BooleanEnum.NO);
			}
			if(t.getEmail()==null){
				t.setEmail(BooleanEnum.NO);
			}
			if(t.getSms()==null){
				t.setSms(BooleanEnum.NO);
			}
			session.save(t);
				if(t.getSms()!=null&&t.getSms().equals(BooleanEnum.YES)){
					SMSDto sms = new SMSDto();
					sms.setCreatorId(PbActivator.getSessionUser().getId());
					sms.setCreator(PbActivator.getSessionUser().getRealName());
					sms.setContent("跟进管理提醒:"+t.getTitle()+"[OA系统]");
					sms.setTimeType(SendTimeTypeEnum.CUSTOMER);
					if(t.getPromotTime()!=null){
						sms.setSendTime(t.getPromotTime());
					}
					List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
					SMSReceiverDto smsReceiverDto = new SMSReceiverDto();
					smsReceiverDto.setReceiverName(PbActivator.getSessionUser().getRealName());
					smsReceiverDto.setSmsReceiverId(PbActivator.getSessionUser().getId());
					smsReceiverDto.setPhone(PbActivator.getSessionUser().getMobile());
					receiverList.add(smsReceiverDto);
					sms.setReceiverList(receiverList);
					if(PbActivator.getService(SMSPubService.class)!=null){
						PbActivator.getService(SMSPubService.class).send(sms,session);
					}
					t.setSmsId(sms.getSmsId());
					session.merge(t);
				}
				if((t.getEmail()!=null&&t.getEmail().equals(BooleanEnum.YES))||(t.getDefaultEmail()!=null&&t.getDefaultEmail().equals(BooleanEnum.YES))){
					EmailDto email = new EmailDto();
					email.setCreatorId(PbActivator.getSessionUser().getId());
					email.setCreator(PbActivator.getSessionUser().getRealName());
					email.setContent("跟进管理提醒:"+t.getTitle()+"[OA系统]");
					email.setTimeType(SendTimeTypeEnum.CUSTOMER);
					if(t.getPromotTime()!=null){
						email.setSendTime(t.getPromotTime());
					}
					List<EmailReceiverDto> receiverList = new ArrayList<EmailReceiverDto>();
					EmailReceiverDto emailReceiverDto = new EmailReceiverDto();
					emailReceiverDto.setReceiverId(PbActivator.getSessionUser().getId());
					emailReceiverDto.setReceiverName(PbActivator.getSessionUser().getRealName());
					emailReceiverDto.setAddress(PbActivator.getSessionUser().getEmail());
					receiverList.add(emailReceiverDto);
					email.setReceiverList(receiverList);
					if(PbActivator.getService(SysEmailSenderPubService.class)!=null){
						PbActivator.getService(SysEmailSenderPubService.class).send(email,session);
					}
					t.setEmailId(email.getId());
					session.merge(t);
				}
			tr.commit();
			PbActivator.getOperationLogService().logOP("创建房间跟进【"+t.getTitle()+"】");
			return Result.success(R.RoomMonitor.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMonitor.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.RoomMonitor.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<RoomMonitor> delete(RoomMonitor t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roomMonitorDao.openSession();
			tr = session.beginTransaction();
			if(t.getEmailId()!=null){
				PbActivator.getService(SysEmailSenderPubService.class).deleteById(t.getEmailId(), session);
			}
			if(t.getSmsId()!=null){
				PbActivator.getService(SysEmailSenderPubService.class).deleteById(t.getSmsId(), session);
			}
			PbActivator.getOperationLogService().logOP("删除日程【"+t.getTitle()+"】");
			session.delete(t);
			tr.commit();
			return Result.success(R.RoomMonitor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.RoomMonitor.DELETE_FAILURE);
		} finally{
			session.close();
		}
	}

	@Override
	public Result<RoomMonitor> deleteById(Serializable id) {
		try {
			RoomMonitor roomMonitor = getBeanById(id).getValue();
			delete(roomMonitor);
			return Result.success(R.RoomMonitor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMonitor> deleteByIds(String ids) {
		try {
			List<RoomMonitor> roomMonitors = roomMonitorDao.getObjectListByHql("from RoomMonitor r where r.id in ("+ids+")");
			for (RoomMonitor roomMonitor : roomMonitors) {
				delete(roomMonitor);
			}
			return Result.success(R.RoomMonitor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMonitor> update(RoomMonitor t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomMonitorDao.update(t);
			return Result.success(R.RoomMonitor.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMonitor.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomMonitor> getBeanById(Serializable id) {
		try {
			return Result.value(roomMonitorDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomMonitor> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomMonitorDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMonitor>> getList() {
		try {
			return Result.value(roomMonitorDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMonitor>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomMonitorDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMonitor.LOAD_FAILURE);
		}
	}

}
