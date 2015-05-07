package com.wiiy.web.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.web.entity.EmailData;
import com.wiiy.web.dao.EmailDataDao;
import com.wiiy.web.service.EmailDataService;
import com.wiiy.web.preferences.R;
import com.wiiy.web.Activator;

/**
 * @author my
 */
public class EmailDataServiceImpl implements EmailDataService{
	
	private EmailDataDao emailDataDao;
	
	public void setEmailDataDao(EmailDataDao emailDataDao) {
		this.emailDataDao = emailDataDao;
	}

	@Override
	public Result<EmailData> save(EmailData t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(null);
			t.setCreatorId(null);
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			emailDataDao.save(t);
			return Result.success(R.EmailData.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),EmailData.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.SAVE_FAILURE);
		}
	}

	@Override
	public Result<EmailData> delete(EmailData t) {
		try {
			emailDataDao.delete(t);
			return Result.success(R.EmailData.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.DELETE_FAILURE);
		}
	}

	@Override
	public Result<EmailData> deleteById(Serializable id) {
		try {
			emailDataDao.deleteById(id);
			return Result.success(R.EmailData.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.DELETE_FAILURE);
		}
	}

	@Override
	public Result<EmailData> deleteByIds(String ids) {
		try {
			emailDataDao.deleteByIds(ids);
			return Result.success(R.EmailData.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(Activator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.DELETE_FAILURE);
		}
	}

	@Override
	public Result<EmailData> update(EmailData t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(null);
			t.setModifierId(null);
			emailDataDao.update(t);
			return Result.success(R.EmailData.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),EmailData.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<EmailData> getBeanById(Serializable id) {
		try {
			return Result.value(emailDataDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.LOAD_FAILURE);
		}
	}

	@Override
	public Result<EmailData> getBeanByFilter(Filter filter) {
		try {
			return Result.value(emailDataDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<EmailData>> getList() {
		try {
			return Result.value(emailDataDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<EmailData>> getListByFilter(Filter filter) {
		try {
			return Result.value(emailDataDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.EmailData.LOAD_FAILURE);
		}
	}

}
