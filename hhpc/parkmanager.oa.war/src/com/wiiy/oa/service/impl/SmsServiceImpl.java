package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SmsDao;
import com.wiiy.oa.dao.SmsReceiverDao;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SmsService;

/**
 * @author my
 */
public class SmsServiceImpl implements SmsService{
	
	private SmsDao smsDao;
	private SmsReceiverDao smsReceiverDao;
	
	public void setSmsDao(SmsDao smsDao) {
		this.smsDao = smsDao;
	}
	public void setSmsReceiverDao(SmsReceiverDao smsReceiverDao) {
		this.smsReceiverDao = smsReceiverDao;
	}
	
	@Override
	public Result save(Sms t, String receiverName) {
		try {
//			System.out.println(receiverName);
//			
//			Config config=OaActivator.getAppConfig().getConfig("SmsSign");
//			String smsName=config.getParameter("name");
//			t.setContent(t.getContent()+smsName);
			
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setSended(BooleanEnum.NO);
			smsDao.save(t);
			OaActivator.getOperationLogService().logOP("发送短信【"+t.getContent()+"】");
			
			SmsReceiver smsReceiver = new SmsReceiver();
			smsReceiver.setCreateTime(new Date());
			smsReceiver.setCreator(OaActivator.getSessionUser().getRealName());
			smsReceiver.setCreatorId(OaActivator.getSessionUser().getId());
			smsReceiver.setModifyTime(smsReceiver.getCreateTime());
			smsReceiver.setModifier(smsReceiver.getCreator());
			smsReceiver.setModifierId(smsReceiver.getCreatorId());
			smsReceiver.setEntityStatus(EntityStatus.NORMAL);
			smsReceiver.setSended(BooleanEnum.NO);
			//收信人
			String[] receive = receiverName.split(";");
			String recever = "";
			String phone = "";
			boolean flag = false;
			for (String s : receive) {
				if(s.trim()!=""){
					flag = true;
					String[] data = s.split("<");
					if(data[0]!=""){
						if(data.length==2){
							recever = data[0];
							if(data[1].split(">").length>0){
								phone = data[1].split(">")[0];
							}else{
								phone = "";
							}
						}else if(data.length==1){
							recever = data[0];
							phone = data[0];
						}
						smsReceiver.setSmsId(t.getId());
						smsReceiver.setReceiverName(recever);
						smsReceiver.setPhone(phone);
						smsReceiverDao.save(smsReceiver);
					}
				}
			}
			if(!flag){
				smsReceiver.setSmsId(t.getId());
				smsReceiver.setReceiverName(recever);
				smsReceiver.setPhone(phone);
				smsReceiverDao.save(smsReceiver);
			}
			return Result.success("该短信已提交发送请求");
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Sms.class)));
		} catch (Exception e) {
			return Result.failure("该短信提交发送请求失败");
		}
	}
	
	@Override
	public Result<Sms> save(Sms t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setSended(BooleanEnum.NO);
			smsDao.save(t);
			return Result.success("该短信已提交发送请求");
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Sms.class)));
		} catch (Exception e) {
			return Result.failure("该短信提交发送请求失败");
		}
	}

	@Override
	public Result<Sms> delete(Sms t) {
		try {
			smsDao.delete(t);
			return Result.success(R.Sms.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Sms.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Sms> deleteById(Serializable id) {
		try {
			List<SmsReceiver> smsReceivers = smsReceiverDao.getListByHql("from SmsReceiver where smsId="+id);
			if(smsReceivers!=null||smsReceivers.size()!=0){
				for(SmsReceiver smsReceiver:smsReceivers){
					smsReceiverDao.deleteById(smsReceiver.getId());
				}
			}
			smsDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除短信:id为【"+id+"】");
			return Result.success(R.Sms.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Sms.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Sms> deleteByIds(String ids) {
		try {
			smsDao.deleteByIds(ids);
			return Result.success(R.Sms.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Sms.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Sms> update(Sms t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			smsDao.update(t);
			return Result.success(R.Sms.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Sms.class)));
		} catch (Exception e) {
			return Result.failure(R.Sms.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Sms> getBeanById(Serializable id) {
		try {
			return Result.value(smsDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Sms.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Sms> getBeanByFilter(Filter filter) {
		try {
			return Result.value(smsDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Sms.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Sms>> getList() {
		try {
			return Result.value(smsDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Sms.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Sms>> getListByFilter(Filter filter) {
		try {
			return Result.value(smsDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Sms.LOAD_FAILURE);
		}
	}

	@Override
	public Result updateSmsToSended(Sms t) {
		smsDao.update(t);
		return Result.success(R.Sms.UPDATE_SUCCESS);
	}


}
