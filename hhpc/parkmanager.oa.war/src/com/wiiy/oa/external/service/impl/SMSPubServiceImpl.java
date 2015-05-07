package com.wiiy.oa.external.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SmsDao;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;

public class SMSPubServiceImpl implements SMSPubService {
	
	private SmsDao smsDao;
	public void setSmsDao(SmsDao smsDao) {
		this.smsDao = smsDao;
	}
	
	/**
	 * 发送短信
	 * @param sms
	 * @return
	 */
	public Result<SMSDto> send(SMSDto sms,Session session) {
		Sms s = new Sms();
		s.setContent(sms.getContent());
		s.setSended(BooleanEnum.NO);
		Date time = new Date();
		if(sms.getSendTime()!=null){
			time = sms.getSendTime();
		}
		s.setSendTime(time);
		s.setTimeType(sms.getTimeType());
		s.setCreateTime(new Date());
		if(sms.getCreator()==null){//没有发送人,默认为admin
			Long userId = Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name"));
			sms.setCreatorId(userId);
			sms.setCreator("管理员");
		}
		s.setCreator(sms.getCreator());
		s.setCreatorId(sms.getCreatorId());
		s.setEntityStatus(EntityStatus.NORMAL);
		session.save(s);
		for (SMSReceiverDto dto : sms.getReceiverList()) {
			SmsReceiver receiver = new SmsReceiver();
			receiver.setCreateTime(new Date());
			receiver.setCreator(s.getCreator());
			receiver.setCreatorId(s.getCreatorId());
			receiver.setEntityStatus(EntityStatus.NORMAL);
			receiver.setPhone(dto.getPhone());
			receiver.setReceiverName(dto.getReceiverName());
			receiver.setSended(s.getSended());
			receiver.setSmsId(s.getId());
			session.save(receiver);
		}
		sms.setSmsId(s.getId());
		return Result.value(sms);
	}

	/**
	 * 发送短信
	 * @param sms
	 * @return
	 */
	public Result<SMSDto> send(SMSDto sms) {
		Session session = null;
		try {
			session = smsDao.openSession();
			return send(sms,session);
		} catch (Exception e) {
			return null;
		} finally {
			session.close();
		}
	}
	@Override
	public Result deleteById(Long id,Session session) {
		session.createQuery("delete from SmsReceiver where smsId = "+id);
		session.createQuery("delete from Sms where id = "+id);
		return Result.success();
	}

	@Override
	public Result deleteReceiverById(Long id,Session session) {
		session.createQuery("delete from SmsReceiver where id = "+id);
		return Result.success();
	}

	@Override
	public Result<SMSDto> send(String receiverMobile, String content, String receiverName) {
		Session session = null;
		try {
			session = smsDao.openSession();
			return send(receiverMobile,content, receiverName ,session);
		} catch (Exception e) {
			return null;
		} finally {
			session.close();
		}
	}
	@Override
	public Result<SMSDto> send(String receiverMobile, String content, String receiverName,Session session) {
		SMSDto sms = new SMSDto();
		sms.setContent(content);
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		SMSReceiverDto receiver = new SMSReceiverDto();
		receiver.setPhone(receiverMobile);
		receiver.setReceiverName(receiverName);
		receiverList.add(receiver);
		sms.setReceiverList(receiverList);
		sms.setCreator(OaActivator.getSessionUser().getRealName());
		sms.setCreatorId(OaActivator.getSessionUser().getId());
		return send(sms,session);
	}

	@Override
	public Result<SMSDto> send(String[] receiverMobile, String content, String[] receiverName,Session session) {
		SMSDto sms = new SMSDto();
		sms.setContent(content);
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		for (int i=0;i<receiverMobile.length;i++) {
			SMSReceiverDto receiver = new SMSReceiverDto();
			receiver.setPhone(receiverMobile[i]);
			receiver.setReceiverName(receiverName[i]);
			receiverList.add(receiver);
		}
		sms.setReceiverList(receiverList);
		sms.setCreator(OaActivator.getSessionUser().getRealName());
		sms.setCreatorId(OaActivator.getSessionUser().getId());
		return send(sms,session);
	}
	
	@Override
	public Result<SMSDto> send(String[] receiverMobile, String[] content, String[] receiverName,Session session) {
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		SMSDto sms = null;
		for (int i=0;i<receiverMobile.length;i++) {
			sms = new SMSDto();
			sms.setContent(content[i]);
			SMSReceiverDto receiver = new SMSReceiverDto();
			receiver.setPhone(receiverMobile[i]);
			receiver.setReceiverName(receiverName[i]);
			receiverList.add(receiver);
			sms.setReceiverList(receiverList);
			send(sms,session);
		}
		return Result.value(sms);
	}
	
	@Override
	public Result<SMSDto> send(String[] receiverMobile, String[] content, String[] receiverName) {
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		SMSDto sms = null;
		for (int i=0;i<receiverMobile.length;i++) {
			sms = new SMSDto();
			sms.setContent(content[i]);
			SMSReceiverDto receiver = new SMSReceiverDto();
			receiver.setPhone(receiverMobile[i]);
			receiver.setReceiverName(receiverName[i]);
			receiverList.add(receiver);
			sms.setReceiverList(receiverList);
			send(sms);
		}
		return Result.value(sms);
	}

	@Override
	public Result<SMSDto> sendByAdmin(String[] receiverMobile, String[] content, String[] receiverName) {
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		SMSDto sms = null;
		for (int i=0;i<receiverMobile.length;i++) {
			sms = new SMSDto();
			sms.setContent(content[i]);
			SMSReceiverDto receiver = new SMSReceiverDto();
			receiver.setPhone(receiverMobile[i]);
			receiver.setReceiverName(receiverName[i]);
			receiverList.add(receiver);
			sms.setReceiverList(receiverList);
			Long userId = Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name"));
			if(OaActivator.getUserById(userId)!=null){
				sms.setCreator(OaActivator.getUserById(userId).getRealName());
				sms.setCreatorId(userId);
			}else{
				sms.setCreator("超级管理员");
			}
			send(sms);
		}
		return Result.value(sms);
	}

	@Override
	public Result<SMSDto> sendByAdmin(String receiverMobile, String content, String receiverName) {
		SMSDto sms = new SMSDto();
		sms.setContent(content);
		List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
		SMSReceiverDto receiver = new SMSReceiverDto();
		receiver.setPhone(receiverMobile);
		receiver.setReceiverName(receiverName);
		receiverList.add(receiver);
		sms.setReceiverList(receiverList);
		Long userId = Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name"));
		if(OaActivator.getUserById(userId)!=null){
			sms.setCreator(OaActivator.getUserById(userId).getRealName());
			sms.setCreatorId(userId);
		}else{
			sms.setCreator("超级管理员");
		}
		return send(sms);
	}
	
}
