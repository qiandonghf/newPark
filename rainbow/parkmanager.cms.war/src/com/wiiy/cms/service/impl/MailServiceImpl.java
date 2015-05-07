package com.wiiy.cms.service.impl;


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
import com.wiiy.cms.entity.Mail;
import com.wiiy.cms.dao.MailDao;
import com.wiiy.cms.service.MailService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class MailServiceImpl implements MailService{
	
	private MailDao mailDao;
	
	public void setMailDao(MailDao mailDao) {
		this.mailDao = mailDao;
	}

	@Override
	public Result<Mail> save(Mail t) {
		try {
			t.setCreateTime(new Date());
			User user = CmsActivator.getSessionUser();
			if (user != null) {
				t.setCreator(CmsActivator.getSessionUser().getRealName());
				t.setCreatorId(CmsActivator.getSessionUser().getId());
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			mailDao.save(t);
			return Result.success(R.Mail.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Mail.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Mail> delete(Mail t) {
		try {
			mailDao.delete(t);
			return Result.success(R.Mail.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Mail> deleteById(Serializable id) {
		try {
			mailDao.deleteById(id);
			return Result.success(R.Mail.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Mail> deleteByIds(String ids) {
		try {
			mailDao.deleteByIds(ids);
			return Result.success(R.Mail.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Mail> update(Mail t) {
		try {
			t.setModifyTime(new Date());
			User user = CmsActivator.getSessionUser();
			if (user != null) {
				t.setModifier(user.getRealName());
				t.setModifierId(user.getId());
			}
			mailDao.update(t);
			return Result.success(R.Mail.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Mail.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Mail> getBeanById(Serializable id) {
		try {
			return Result.value(mailDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Mail> getBeanByFilter(Filter filter) {
		try {
			return Result.value(mailDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Mail>> getList() {
		try {
			return Result.value(mailDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Mail>> getListByFilter(Filter filter) {
		try {
			return Result.value(mailDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Mail.LOAD_FAILURE);
		}
	}

}
