package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SmsTemplateDao;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.entity.SmsTemplate;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SmsTemplateService;

public class SmsTemplateServiceImpl implements SmsTemplateService{
	private SmsTemplateDao smsTemplateDao;
	@Override
	public Result<SmsTemplate> save(SmsTemplate t) {
		Session session = null;
		Transaction tr = null;
		//将新建短信模板名称进行处理，方便与表中的对应字段进行比较
		String smsTemplateName = t.getName().trim();
		try{
			session = smsTemplateDao.openSession();
			tr = session.beginTransaction();
			//将数据取出判断是否重名
			List<SmsTemplate> smsTemplateList = new ArrayList<SmsTemplate>();
			smsTemplateList = session.createQuery("from SmsTemplate").list();
			for (SmsTemplate smsTemplate : smsTemplateList) {
				if(smsTemplate.getName().equals(smsTemplateName)){
					return Result.failure("该短信模板名称已存在，请重新输入");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			smsTemplateDao.save(t);
			tr.commit();
			OaActivator.getOperationLogService().logOP("添加短信模板【"+t.getName()+"】");
			return Result.success(R.SmsTemplate.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), SmsTemplate.class)));
		}catch(Exception e){
			return Result.failure(R.SmsTemplate.SAVE_FAILURE);
		}finally{
			session.close();
		}	
	}

	@Override
	public Result<SmsTemplate> delete(SmsTemplate t) {
		try{
			smsTemplateDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除短信模板【"+t.getName()+"】");
			return Result.success(R.SmsTemplate.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));			
		}catch(Exception e){
			return Result.failure(R.SmsTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsTemplate> deleteById(Serializable id) {
		try {
			smsTemplateDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的短信模板");
			return Result.success(R.SmsTemplate.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsTemplate> deleteByIds(String ids) {
		try {
			smsTemplateDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的短信模板");
			}
			return Result.success(R.SmsTemplate.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SmsTemplate> update(SmsTemplate t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			smsTemplateDao.update(t);
			OaActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的短信模板");
			return Result.success(R.SmsTemplate.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SmsTemplate.class)));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SmsTemplate> getBeanById(Serializable id) {
		try {
			return Result.value(smsTemplateDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SmsTemplate> getBeanByFilter(Filter filter) {
		try {
			return Result.value(smsTemplateDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SmsTemplate>> getList() {
		try {
			return Result.value(smsTemplateDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SmsTemplate>> getListByFilter(Filter filter) {
		try {
			return Result.value(smsTemplateDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SmsTemplate.LOAD_FAILURE);
		}
	}

	public void setSmsTemplateDao(SmsTemplateDao smsTemplateDao) {
		this.smsTemplateDao = smsTemplateDao;
	}

}
